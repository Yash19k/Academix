from flask import Flask, render_template, request, redirect, url_for, session, jsonify,flash
from werkzeug.security import generate_password_hash, check_password_hash
from db import get_db_connection
from datetime import datetime, timedelta
import os
import re
import google.generativeai as genai
import pdfplumber
import json


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_DIR = os.path.join(BASE_DIR, "templates")

app = Flask(__name__, template_folder=TEMPLATE_DIR)
print("Flask is using templates from:", TEMPLATE_DIR)
print("Templates found:", os.listdir(TEMPLATE_DIR))

app.secret_key = "super-secret-key"

# 🔐 CONFIGURE GEMINI (PUT YOUR KEY HERE)
genai.configure(api_key="AIzaSyB7suCTeJMV_6xQj3E2-JP0x6gBf-nWJAA")
model = genai.GenerativeModel("gemini-2.5-flash")

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def get_time_ago(timestamp):
    """Convert timestamp to human-readable time ago format"""
    if not timestamp:
        return "Unknown"
    
    now = datetime.now()
    diff = now - timestamp
    
    if diff.days > 365:
        return f"{diff.days // 365}y ago"
    elif diff.days > 30:
        return f"{diff.days // 30}mo ago"
    elif diff.days > 0:
        return f"{diff.days}d ago"
    elif diff.seconds > 3600:
        return f"{diff.seconds // 3600}h ago"
    elif diff.seconds > 60:
        return f"{diff.seconds // 60}m ago"
    else:
        return "Just now"

def get_user_info():
    """Get current logged-in user information"""
    if "user_id" not in session:
        return None
    
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE id=%s", (session["user_id"],))
    user = cursor.fetchone()
    cursor.close()
    db.close()
    return user

def get_unread_notifications_count(user_id):
    """Get count of unread notifications for a user"""
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT COUNT(*) as count
        FROM chat_notifications
        WHERE user_id = %s AND is_read = 0
    """, (user_id,))
    result = cursor.fetchone()
    cursor.close()
    db.close()
    return result['count'] if result else 0

# ============================================================================
# AUTHENTICATION ROUTES
# ============================================================================

@app.route("/")
def home():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT COUNT(*) as total FROM users")
    total_users = cursor.fetchone()["total"]

    cursor.execute("SELECT COUNT(*) as total FROM courses")
    total_courses = cursor.fetchone()["total"]

    cursor.execute("SELECT COUNT(*) as total FROM internship_roles")
    total_internships = cursor.fetchone()["total"]

    cursor.close()
    db.close()

    return render_template("landing.html",
                           total_users=total_users,
                           total_courses=total_courses,
                           total_internships=total_internships)

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("username")
        email = request.form.get("email")
        password = request.form.get("password")

        # PASSWORD VALIDATION (BACKEND)
        pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$'

        if not re.match(pattern, password):
            return render_template(
                "register.html",
                error="Password must be at least 8 characters long and include uppercase, lowercase, number, and special character."
            )

        hashed_password = generate_password_hash(password)

        try:
            db = get_db_connection()
            cursor = db.cursor()

            cursor.execute(
                "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
                (username, email, hashed_password)
            )

            db.commit()
            cursor.close()
            db.close()

            return render_template(
                "register.html",
                success="Registration successful! Please login."
            )

        except:
            return render_template(
                "register.html",
                error="Email already registered"
            )

    return render_template("register.html")

# ---------------- LOGIN ----------------
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        cursor.execute(
            "SELECT * FROM users WHERE email=%s",
            (email,)
        )
        user = cursor.fetchone()

        cursor.close()
        db.close()

        if user and check_password_hash(user["password"], password):
            session["user_id"] = user["id"]
            session["user"] = user["email"]
            session["username"] = user["username"]
            session["access_type"] = user.get("access_type", "student")

            # 🔥 Redirect based on access type
            if session["access_type"] == "admin":
                return redirect(url_for("admin"))
            else:
                return redirect(url_for("dashboard"))
        else:
            return render_template(
                "login.html",
                error="Invalid email or password"
            )

    return render_template("login.html")

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))

# ============================================================================
# DASHBOARD & COURSE ROUTES
# ============================================================================

@app.route("/dashboard")
def dashboard():

    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Courses enrolled
    cursor.execute("""
        SELECT COUNT(*) AS total
        FROM enrollments
        WHERE user_id=%s
    """, (user_id,))
    courses_enrolled = cursor.fetchone()["total"]

    # Lessons completed
    cursor.execute("""
        SELECT COUNT(*) AS total
        FROM lesson_progress
        WHERE user_id=%s AND completed=1
    """, (user_id,))
    lessons_completed = cursor.fetchone()["total"]

    # Average grade %
    cursor.execute("""
        SELECT IFNULL(AVG((score/total)*100),0) AS avg_grade
        FROM module_quiz_results
        WHERE user_id=%s
    """, (user_id,))
    avg_grade = round(cursor.fetchone()["avg_grade"], 1)

    # Get enrolled courses
    cursor.execute("""
        SELECT c.id, c.title
        FROM courses c
        INNER JOIN enrollments e ON c.id = e.course_id
        WHERE e.user_id=%s
    """, (user_id,))
    courses = cursor.fetchall()

    # Calculate progress
    for course in courses:

        cursor.execute("""
            SELECT COUNT(*) AS total_lessons
            FROM lessons l
            INNER JOIN modules m ON l.module_id = m.id
            WHERE m.course_id=%s
        """, (course["id"],))

        total = cursor.fetchone()["total_lessons"]

        cursor.execute("""
            SELECT COUNT(*) AS completed
            FROM lesson_progress lp
            INNER JOIN lessons l ON lp.lesson_id = l.id
            INNER JOIN modules m ON l.module_id = m.id
            WHERE lp.user_id=%s
            AND lp.completed=1
            AND m.course_id=%s
        """, (user_id, course["id"]))
        completed = cursor.fetchone()["completed"]

        course["progress"] = int((completed / total) * 100) if total else 0
        course["total"] = total
        course["completed"] = completed

    cursor.close()
    db.close()

    return render_template(
        "dashboard.html",
        courses_enrolled=courses_enrolled,
        lessons_completed=lessons_completed,
        avg_grade=avg_grade,
        courses=courses,
        user=session["user"],
        username=session["username"])

@app.route("/course_catalog", methods=["GET", "POST"])
def course_catalog():
    if "user" not in session:
        return redirect(url_for("login"))

    subject = request.args.get("subject")
    level = request.args.get("level")
    sort = request.args.get("sort")
    search = request.args.get("search")

    query = "SELECT * FROM courses WHERE 1=1"
    params = []

    if subject and subject != "All":
        query += " AND subject=%s"
        params.append(subject)

    if level and level != "All":
        query += " AND level=%s"
        params.append(level)

    if search:
        query += " AND title LIKE %s"
        params.append(f"%{search}%")

    if sort == "rating":
        query += " ORDER BY rating DESC"
    elif sort == "az":
        query += " ORDER BY title ASC"

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute(query, params)
    courses = cursor.fetchall()
    cursor.close()
    db.close()

    return render_template(
        "course_catalog.html",
        courses=courses,
        subject=subject,
        level=level,
        sort=sort,
        search=search
    )

@app.route("/course_detail")
def course_detail():
    if "user_id" not in session:
        return redirect(url_for("login"))

    course_id = request.args.get("id")
    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
    SELECT c.*, f.name AS faculty_name
    FROM courses c
    LEFT JOIN faculties f ON c.faculty_id = f.id
    WHERE c.id = %s
    """, (course_id,))

    course = cursor.fetchone()

    cursor.execute("""
        SELECT * FROM enrollments
        WHERE user_id=%s AND course_id=%s
    """, (user_id, course_id))
    enrollment = cursor.fetchone()

    cursor.execute("""
        SELECT 
            m.*,
            COUNT(l.id) AS total_lessons,
            SUM(CASE WHEN lp.completed = 1 THEN 1 ELSE 0 END) AS completed_lessons
        FROM modules m
        LEFT JOIN lessons l ON m.id = l.module_id
        LEFT JOIN lesson_progress lp 
            ON l.id = lp.lesson_id AND lp.user_id = %s
        WHERE m.course_id = %s
        GROUP BY m.id
        ORDER BY m.order_no
    """, (user_id, course_id))
    modules = cursor.fetchall()

    for module in modules:
        cursor.execute("""
            SELECT 
                l.*,
                lp.completed
            FROM lessons l
            LEFT JOIN lesson_progress lp 
                ON l.id = lp.lesson_id AND lp.user_id = %s
            WHERE l.module_id = %s
            ORDER BY l.order_no
        """, (user_id, module["id"]))
        module["lessons"] = cursor.fetchall()
        
        # 🔹 Get quiz for this module
        cursor.execute("""
            SELECT * FROM module_quizzes
            WHERE module_id = %s
        """, (module["id"],))

        quiz = cursor.fetchone()
        module["quiz"] = quiz


    total_lessons = 0
    completed_lessons = 0
    for module in modules:
        total_lessons += module["total_lessons"]
        completed_lessons += module["completed_lessons"]

    if total_lessons > 0:
        course_progress = int((completed_lessons / total_lessons) * 100)
    else:
        course_progress = 0
    # 🔓 Check if course is fully completed
    course_completed = (course_progress == 100)


    cursor.execute("""
        SELECT l.id
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        LEFT JOIN lesson_progress lp
            ON l.id = lp.lesson_id AND lp.user_id = %s
        WHERE m.course_id = %s
        AND (lp.completed IS NULL OR lp.completed = 0)
        ORDER BY m.order_no, l.order_no
        LIMIT 1
    """, (user_id, course_id))

    resume_lesson = cursor.fetchone()
    if not resume_lesson:
        cursor.execute("""
            SELECT l.id
            FROM lessons l
            JOIN modules m ON l.module_id = m.id
            WHERE m.course_id = %s
            ORDER BY m.order_no DESC, l.order_no DESC
            LIMIT 1
        """, (course_id,))
    
    resume_lesson = cursor.fetchone()
    
    cursor.close()
    db.close()

    return render_template(
        "course_detail.html",
        course=course,
        modules=modules,
        course_progress=course_progress,
        resume_lesson=resume_lesson,
        enrollment=enrollment,
        course_completed=course_completed
    )

@app.route("/enroll/<int:course_id>", methods=["POST"])
def enroll(course_id):
    if "user_id" not in session:
        return redirect(url_for("login"))

    try:
        db = get_db_connection()
        cursor = db.cursor()

        cursor.execute(
            "INSERT INTO enrollments (user_id, course_id) VALUES (%s, %s)",
            (session["user_id"], course_id)
        )

        db.commit()
        cursor.close()
        db.close()

    except:
        pass

    return redirect(url_for("course_detail", id=course_id))

@app.route("/lesson/<int:lesson_id>")
def lesson_content(lesson_id):
    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT l.*, m.course_id
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE l.id=%s
    """, (lesson_id,))
    lesson = cursor.fetchone()

    if not lesson:
        return "Lesson not found", 404

    cursor.execute("SELECT * FROM courses WHERE id=%s", (lesson["course_id"],))
    course = cursor.fetchone()

    cursor.execute("""
        SELECT completed
        FROM lesson_progress
        WHERE user_id=%s AND lesson_id=%s
    """, (user_id, lesson_id))
    progress = cursor.fetchone()

    lesson["completed"] = progress and progress["completed"] == 1

    cursor.close()
    db.close()

    return render_template(
        "lesson_content.html",
        user=session["user"],
        lesson=lesson,
        course=course
    )

@app.route("/mark-complete/<int:lesson_id>", methods=["POST"])
def mark_complete(lesson_id):
    if "user_id" not in session:
        return {"success": False}

    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT * FROM lesson_progress
        WHERE user_id=%s AND lesson_id=%s
    """, (user_id, lesson_id))

    existing = cursor.fetchone()

    if not existing:
        cursor.execute("""
            SELECT content_type
            FROM lessons
            WHERE id=%s
        """, (lesson_id,))

        lesson = cursor.fetchone()

        if lesson["content_type"] == "note":
            points = 5
        elif lesson["content_type"] == "video":
            points = 10
        elif lesson["content_type"] == "quiz":
            points = 20
        else:
            points = 5

        cursor.execute("""
            INSERT INTO lesson_progress (user_id, lesson_id, completed)
            VALUES (%s, %s, 1)
        """, (user_id, lesson_id))
        
        # 🔥 Insert into user_activity
        cursor.execute("""
            SELECT content_type, module_id
            FROM lessons
            WHERE id=%s
        """, (lesson_id,))
        lesson_data = cursor.fetchone()

        cursor.execute("""
            INSERT INTO user_activity (user_email, chapter_id, type, completed)
            VALUES (%s, %s, %s, 1)
        """, (
            session["user"],
            lesson_data["module_id"],  # using module as chapter
            lesson_data["content_type"]
        ))

        cursor.execute("""
            UPDATE users
            SET points = points + %s
            WHERE id=%s
        """, (points, user_id))

    db.commit()
    cursor.close()
    db.close()

    return {"success": True}

# ============================================================================
# LEADERBOARD & ADMIN
# ============================================================================

@app.route("/leaderboard")
def leaderboard():
    if "user_id" not in session:
        return redirect(url_for("login"))
    
    # Color generation function - make it unique for everyone
    import hashlib
    def get_color_from_username(username):
        # Create a unique color based on username hash
        hash_object = hashlib.md5(username.encode())
        hex_dig = hash_object.hexdigest()
        
        # Extract RGB values from hash
        r = int(hex_dig[0:2], 16)
        g = int(hex_dig[2:4], 16)
        b = int(hex_dig[4:6], 16)
        
        # Create a nice gradient with some variation
        r2 = min(255, r + 50)
        g2 = min(255, g + 50)
        b2 = min(255, b + 50)
        
        return f'linear-gradient(135deg, rgb({r}, {g}, {b}) 0%, rgb({r2}, {g2}, {b2}) 100%)'
    
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Get leaderboard ordered by points (exclude admin users)
    cursor.execute("""
        SELECT u.id, u.username, u.points, u.level, u.streak,
               COUNT(lp.id) as lessons_completed
        FROM users u
        LEFT JOIN lesson_progress lp ON u.id = lp.user_id AND lp.completed = 1
        WHERE u.access_type != 'admin'
        GROUP BY u.id, u.username, u.points, u.level, u.streak
        ORDER BY u.points DESC
    """)
    users = cursor.fetchall()

    # Add dynamic progress calculation and unique colors
    for user in users:
        # Calculate progress percentage (assuming 100 lessons total)
        total_lessons = 100
        user['progress_percent'] = min(100, (user['lessons_completed'] / total_lessons) * 100)
        user['current_level'] = max(1, user['lessons_completed'] // 10 + 1)
        
        # Add unique color for each user
        user['avatar_color'] = get_color_from_username(user['username'])
        
        # Determine level badge class based on points
        points = user['points']
        if points >= 500:
            user['level'] = 'Expert'
        elif points >= 200:
            user['level'] = 'Advanced'
        elif points >= 50:
            user['level'] = 'Intermediate'
        else:
            user['level'] = 'Novice'

    # Find current user rank
    current_user_id = session["user_id"]
    current_rank = None
    current_user_points = 0
    current_user_streak = 0
    
    for index, user in enumerate(users):
        if user["id"] == current_user_id:
            current_rank = index + 1
            current_user_points = user['points']
            current_user_streak = user['streak']
            break

    # Top 3 users
    top_three = users[:3]

    # Get weekly top performer (last 7 days)
    cursor.execute("""
        SELECT u.username, 
               COUNT(lp.id) as lessons_this_week,
               SUM(CASE WHEN l.content_type = 'note' THEN 5 
                        WHEN l.content_type = 'video' THEN 10 
                        WHEN l.content_type = 'quiz' THEN 20 
                        ELSE 5 END) as points_this_week
        FROM users u
        JOIN lesson_progress lp ON u.id = lp.user_id
        JOIN lessons l ON lp.lesson_id = l.id
        WHERE lp.completed_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        AND u.access_type != 'admin'
        AND lp.completed = 1
        GROUP BY u.id, u.username
        ORDER BY points_this_week DESC
        LIMIT 1
    """)
    weekly_top = cursor.fetchone()
    
    weekly_top_performer = None
    if weekly_top:
        weekly_top_performer = {
            'name': weekly_top['username'],
            'points': weekly_top['points_this_week'],
            'lessons': weekly_top['lessons_this_week']
        }

    # Get most consistent user (highest streak)
    cursor.execute("""
        SELECT username, streak
        FROM users
        WHERE access_type != 'admin'
        ORDER BY streak DESC
        LIMIT 1
    """)
    consistent_user = cursor.fetchone()
    
    most_consistent = None
    if consistent_user:
        most_consistent = {
            'name': consistent_user['username'],
            'streak': consistent_user['streak']
        }

    cursor.close()
    db.close()

    return render_template(
        "leaderboard.html",
        users=users,
        top_three=top_three,
        current_rank=current_rank,
        current_user_id=current_user_id,
        current_user_points=current_user_points,
        current_user_streak=current_user_streak,
        weekly_top_performer=weekly_top_performer,
        most_consistent=most_consistent,
        get_color_from_username=get_color_from_username
    )

@app.route("/module-quiz/<int:module_id>")
def module_quiz(module_id):

    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Get quiz for this module
    cursor.execute(
        "SELECT * FROM module_quizzes WHERE module_id=%s",
        (module_id,)
    )
    quiz = cursor.fetchone()

    if not quiz:
        cursor.close()
        db.close()
        return "No quiz found for this module", 404

    # Get questions
    cursor.execute("""
        SELECT * FROM module_quiz_questions
        WHERE quiz_id=%s
    """, (quiz["id"],))

    questions = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "module_quiz.html",
        quiz=quiz,
        questions=questions
    )


@app.route("/submit-module-quiz/<int:quiz_id>", methods=["POST"])
def submit_module_quiz(quiz_id):
    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]
    answers = request.form

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Get quiz info (contains total reward points)
    cursor.execute("SELECT * FROM module_quizzes WHERE id=%s", (quiz_id,))
    quiz = cursor.fetchone()

    # Get questions
    cursor.execute("SELECT * FROM module_quiz_questions WHERE quiz_id=%s", (quiz_id,))
    questions = cursor.fetchall()

    score = 0

    for q in questions:
        selected = answers.get(f"question_{q['id']}")
        if selected == q["correct_option"]:
            score += 1

    total = len(questions)

    # 🔥 Calculate percentage
    percentage = (score / total) * 100 if total > 0 else 0

    max_points = quiz["points"]
    points_awarded = int((percentage / 100) * max_points)

    passed = percentage >= 50

    # Save quiz result
    cursor.execute("""
        INSERT INTO module_quiz_results (user_id, quiz_id, score, total, passed)
        VALUES (%s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE score=%s, passed=%s
    """, (user_id, quiz_id, score, total, passed, score, passed))


    # 🔥 Get module id of this quiz
    cursor.execute("""
        SELECT module_id FROM module_quizzes
        WHERE id=%s
    """, (quiz_id,))
    quiz_data = cursor.fetchone()

    # 🔥 Always insert into user_activity (pass or fail)
    cursor.execute("""
        INSERT INTO user_activity (user_email, chapter_id, type, completed)
        VALUES (%s, %s, 'quiz', %s)
    """, (
        session["user"],
        quiz_data["module_id"],
        1 if passed else 0
    ))

    
    if passed:
        cursor.execute("""
            UPDATE users
            SET points = points + %s
            WHERE id=%s
        """, (points_awarded, user_id))
        
    detailed_results = []

    for q in questions:
        selected = answers.get(f"question_{q['id']}")
        is_correct = selected == q["correct_option"]

        detailed_results.append({
            "question": q["question"],
            "option_a": q["option_a"],
            "option_b": q["option_b"],
            "option_c": q["option_c"],
            "option_d": q["option_d"],
            "correct_option": q["correct_option"],
            "selected_option": selected,
            "is_correct": is_correct,
            "explanation": q["explanation"]
        })
    
    db.commit()
    cursor.close()
    db.close()

    return render_template(
        "quiz_result.html",
        score=score,
        total=total,
        percentage=round(percentage, 2),
        points_awarded=points_awarded,
        passed=passed,
        results=detailed_results
    )


#--Resume Text Extraction--
from docx import Document

def extract_text(file_path):
    text = ""

    if file_path.endswith(".pdf"):
        with pdfplumber.open(file_path) as pdf:
            for page in pdf.pages:
                text += page.extract_text() or ""

    elif file_path.endswith(".docx"):
        doc = Document(file_path)
        for para in doc.paragraphs:
            text += para.text + "\n"

    return text.lower()
def extract_skills_from_text(resume_text):
    predefined_skills = [
        "html", "css", "javascript", "react", "node", "python",
        "flask", "django", "mysql", "mongodb", "java",
        "bootstrap", "git", "github", "c++"
    ]

    found_skills = []

    for skill in predefined_skills:
        if skill in resume_text:
            found_skills.append(skill)

    return list(set(found_skills))

#--ATS Scoring Function--
def analyze_resume_with_ai(resume_text, role_name, required_skills):

    prompt = f"""
You are an advanced ATS (Applicant Tracking System).

Analyze this resume for the role: {role_name}

Required Skills:
{required_skills}

Resume Content:
{resume_text}

Return response strictly in this JSON format:

{{
  "ats_score": number between 0-100,
  "strengths": ["point1", "point2"],
  "weaknesses": ["point1", "point2"],
  "missing_keywords": ["keyword1", "keyword2"],
  "section_feedback": {{
      "education": "feedback",
      "experience": "feedback",
      "projects": "feedback",
      "skills": "feedback"
  }},
  "improvement_suggestions": ["suggestion1", "suggestion2"],
  "final_verdict": "Short professional summary"
}}

Be strict and realistic like a real ATS.
"""

    response = model.generate_content(prompt)

    return response.text
#--ATS ROUTE--

@app.route("/ats-checker", methods=["GET", "POST"])
def ats_checker():
    if "user_id" not in session:
        return redirect(url_for("login"))

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM internship_roles")
    roles = cursor.fetchall()

    if request.method == "POST":

        role_id = request.form.get("role")
        file = request.files.get("resume")

        upload_path = os.path.join("static/resumes", file.filename)
        file.save(upload_path)

        resume_text = extract_text(upload_path)
        resume_text = resume_text[:4000]

        cursor.execute("SELECT * FROM internship_roles WHERE id=%s", (role_id,))
        role = cursor.fetchone()
        
        # 🔥 Extract skills
        skills = extract_skills_from_text(resume_text)

        # 🔥 Save skills to DB
        # 🔥 Remove old skills first
        cursor.execute("""
            DELETE FROM user_skills
            WHERE user_id=%s
        """, (session["user_id"],))

        # 🔥 Insert new skills
        for skill in skills:
            cursor.execute("""
                INSERT INTO user_skills (user_id, skill_name)
                VALUES (%s, %s)
            """, (session["user_id"], skill))



        # Get role basic info
        cursor.execute("SELECT * FROM internship_roles WHERE id=%s", (role_id,))
        role = cursor.fetchone()

        # Get required skills from internship_skills table
        cursor.execute("""
            SELECT skill_name FROM internship_skills
            WHERE internship_id=%s
        """, (role_id,))

        required_skills_list = [r["skill_name"] for r in cursor.fetchall()]

        required_skills_text = ", ".join(required_skills_list)

        ai_response = analyze_resume_with_ai(
            resume_text,
            role["role_name"],
            required_skills_text
        )

        # 🔥 STEP 2A: Remove markdown if AI added ```json
        cleaned_response = re.sub(r"```json|```", "", ai_response).strip()

        # 🔥 STEP 2B: Try converting to JSON
        try:
            result = json.loads(cleaned_response)
        except Exception as e:
            print("❌ JSON ERROR:", e)
            print("🔥 RAW AI RESPONSE:", ai_response)

            result = {
                "ats_score": 0,
                "strengths": [],
                "weaknesses": ["AI parsing failed"],
                "missing_keywords": [],
                "section_feedback": {
                    "education": "",
                    "experience": "",
                    "projects": "",
                    "skills": ""
                },
                "improvement_suggestions": [],
                "final_verdict": "Error analyzing resume"
            }

        # Save score
        cursor.execute("""
            INSERT INTO resumes (user_id, role_id, file_path, ats_score)
            VALUES (%s, %s, %s, %s)
        """, (session["user_id"], role_id, upload_path, result["ats_score"]))

        db.commit()
        cursor.close()
        db.close()

        return render_template("ats_result.html", result=result, role=role["role_name"])

    cursor.close()
    db.close()
    return render_template("ats_checker.html", roles=roles)

@app.route("/ai-recommendations")
def ai_recommendations():

    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # 🔒 REQUIRE ATS FIRST
    cursor.execute("""
        SELECT * FROM resumes
        WHERE user_id=%s
        ORDER BY uploaded_at DESC
        LIMIT 1
    """, (user_id,))
    resume = cursor.fetchone()

    if not resume:
        cursor.close()
        db.close()
        flash("Please upload and analyze your resume first.")
        return redirect(url_for("ats_checker"))

    # =============================
    # 1️⃣ GET USER SKILLS
    # =============================
    cursor.execute("""
        SELECT skill_name FROM user_skills
        WHERE user_id=%s
    """, (user_id,))
    user_skills = [row["skill_name"].lower() for row in cursor.fetchall()]

    # =============================
    # 2️⃣ GET INTERNSHIPS
    # =============================
    cursor.execute("SELECT * FROM internship_roles")
    internships = cursor.fetchall()

    results = []

    for internship in internships:

        cursor.execute("""
            SELECT skill_name FROM internship_skills
            WHERE internship_id=%s
        """, (internship["id"],))

        required = [r["skill_name"].lower() for r in cursor.fetchall()]

        matching = list(set(user_skills) & set(required))
        missing = list(set(required) - set(user_skills))

        percent = int((len(matching) / len(required)) * 100) if required else 0

        internship["match_percent"] = percent
        internship["matching_skills"] = matching
        internship["missing_skills"] = missing

        results.append(internship)

    # =============================
    # 3️⃣ SORT BY MATCH %
    # =============================
    results = sorted(results, key=lambda x: x["match_percent"], reverse=True)

    # =============================
    # 4️⃣ STATS (For Dashboard Cards)
    # =============================
    total_internships = len(results)

    highest_match = results[0]["match_percent"] if results else 0

    avg_match = (
        int(sum(r["match_percent"] for r in results) / total_internships)
        if total_internships > 0 else 0
    )

    # Count new internships (last 7 days)
    cursor.execute("""
        SELECT COUNT(*) as count
        FROM internship_roles
        WHERE created_at >= NOW() - INTERVAL 7 DAY
    """)
    new_count = cursor.fetchone()["count"]

    # Top matching skills (most common in matches)
    skill_counter = {}
    for r in results:
        for skill in r["matching_skills"]:
            skill_counter[skill] = skill_counter.get(skill, 0) + 1

    top_skills = sorted(skill_counter, key=skill_counter.get, reverse=True)[:3]
    
    # =============================
    # GET DISTINCT LOCATIONS
    # =============================
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT DISTINCT location FROM internship_roles")
    locations = [row["location"] for row in cursor.fetchall()]

    # =============================
    # GET DISTINCT JOB TYPES
    # =============================
    cursor.execute("SELECT DISTINCT job_type FROM internship_roles")
    job_types = [row["job_type"] for row in cursor.fetchall()]

    # =============================
    # GET MAX STIPEND (for dropdown)
    # =============================
    cursor.execute("SELECT DISTINCT stipend_amount FROM internship_roles ORDER BY stipend_amount")
    stipends = [row["stipend_amount"] for row in cursor.fetchall()]
        
    cursor.close()
    db.close()

    return render_template(
    "ai_recommendations.html",
    internships=results,
    total_internships=total_internships,
    new_count=new_count,
    highest_match=highest_match,
    avg_match=avg_match,
    top_skills=top_skills,
    locations=locations,
    job_types=job_types,
    stipends=stipends
)
    
@app.route("/find-internships")
def find_internships():

    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # 🔥 Get user skills
    cursor.execute("""
        SELECT skill_name FROM user_skills
        WHERE user_id=%s
    """, (user_id,))
    user_skills = [row["skill_name"] for row in cursor.fetchall()]

    # 🔥 Get internships
    cursor.execute("SELECT * FROM internship_roles")
    internships = cursor.fetchall()

    for internship in internships:

        cursor.execute("""
            SELECT skill_name FROM internship_skills
            WHERE internship_id=%s
        """, (internship["id"],))

        required_skills = [row["skill_name"] for row in cursor.fetchall()]

        if required_skills:
            match = len(set(user_skills) & set(required_skills))
            percentage = int((match / len(required_skills)) * 100)
        else:
            percentage = 0

        internship["match_percent"] = percentage
        internship["required_skills"] = required_skills

    # 🔥 Sort by highest match
    internships = sorted(internships, key=lambda x: x["match_percent"], reverse=True)

    cursor.close()
    db.close()

    return render_template("internship_listing.html", internships=internships)


@app.route("/admin", methods=["GET", "POST"])
def admin():
    if "user" not in session:
        return redirect(url_for("login"))

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    message = None
    error = None

    if request.method == "POST":
        faculty_name = request.form.get("fname")
        faculty_dept = request.form.get("fdept")
        faculty_email = request.form.get("fmail")

        if not faculty_name or not faculty_dept or not faculty_email:
            error = "All fields are required"
        else:
            try:
                cursor.execute(
                    "INSERT INTO faculties (name, department, email) VALUES (%s, %s, %s)",
                    (faculty_name, faculty_dept, faculty_email)
                )
                db.commit()
                message = "Faculty added successfully!"
            except Exception as e:
                error = "Failed to add faculty. Email might already exist."

    cursor.execute("SELECT username as name, email, '' as course FROM users")
    students = cursor.fetchall()

    cursor.execute("SELECT name, department as dept, email FROM faculties")
    faculties = cursor.fetchall()

    cursor.execute("SELECT title FROM courses")
    course_data = cursor.fetchall()

    courses = [c["title"] for c in course_data]

    cursor.close()
    db.close()

    return render_template(
        "admin.html",
        students=students,
        faculties=faculties,
        courses=courses,
        message=message,
        error=error
    )

# ============================================================================
# CHATBOT ROUTES
# ============================================================================

@app.route("/chatbot", methods=["GET"])
def chatbot():
    if "user" not in session:
        return redirect(url_for("login"))

    user_email = session["user"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT question, answer FROM chatbot_history WHERE user_email=%s ORDER BY id",
        (user_email,)
    )
    chats = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template("chatbot.html", chats=chats)

@app.route("/api/chat", methods=["POST"])
def api_chat():
    if "user" not in session:
        return jsonify({"error": "Unauthorized"}), 401

    user_email = session["user"]
    data = request.get_json()

    message = data.get("message")
    mode = data.get("mode", "normal")

    if not message:
        return jsonify({"error": "Empty message"}), 400

    prompt = f"""
    You are an AI Student Assistant.
    Answer the question in {mode} mode.

    Question:
    {message}
    """

    try:
        response = model.generate_content(prompt)
        reply = response.text

        db = get_db_connection()
        cursor = db.cursor()

        cursor.execute(
            """
            INSERT INTO chatbot_history (user_email, question, answer)
            VALUES (%s, %s, %s)
            """,
            (user_email, message, reply)
        )

        db.commit()
        cursor.close()
        db.close()

        return jsonify({"reply": reply})

    except Exception as e:
        print("🔥 ERROR:", e)
        return jsonify({"error": "AI service failed"}), 500

@app.route('/api/delete-chat', methods=['POST'])
def delete_chat():
    if "user" not in session:
        return jsonify({"error": "Unauthorized"}), 401

    user_email = session["user"]

    try:
        db = get_db_connection()
        cursor = db.cursor()

        # Delete chat history for the current user
        cursor.execute(
            "DELETE FROM chatbot_history WHERE user_email=%s",
            (user_email,)
        )

        db.commit()
        cursor.close()
        db.close()

        return jsonify({"success": True})

    except Exception as e:
        print("🔥 ERROR deleting chat:", e)
        return jsonify({"error": "Failed to delete chat history"}), 500

@app.route('/api/download-chat', methods=['GET'])
def download_chat():
    if "user" not in session:
        return jsonify({"error": "Unauthorized"}), 401

    user_email = session["user"]

    try:
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        # Get chat history for the current user
        cursor.execute(
            "SELECT question, answer, created_at FROM chatbot_history WHERE user_email=%s ORDER BY id",
            (user_email,)
        )
        chats = cursor.fetchall()

        cursor.close()
        db.close()

        # Format the chat history
        chat_text = f"Academix Chat History - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
        chat_text += "=====================================\n\n"
        
        for chat in chats:
            timestamp = chat['created_at'].strftime('%Y-%m-%d %H:%M:%S')
            chat_text += f"[{timestamp}] You:\n{chat['question']}\n\n"
            chat_text += f"[{timestamp}] Course Assistant:\n{chat['answer']}\n\n"

        # Return the chat history as text
        return jsonify({"chat_text": chat_text})

    except Exception as e:
        print("🔥 ERROR downloading chat:", e)
        return jsonify({"error": "Failed to download chat history"}), 500

# ============================================================================
# STUDENT CHAT ROUTES
# ============================================================================


# ============================================================================
# PROFILE & MISC
# ============================================================================

@app.route("/profile", methods=["GET", "POST"])
def profile():
    if "user" not in session:
        return redirect(url_for("login"))

    email = session["user"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # 🔥 Get full user info (including id)
    cursor.execute("SELECT id, username AS name, email FROM users WHERE email=%s", (email,))
    user = cursor.fetchone()

    user_id = user["id"]   # ✅ FIX 1

    message = None

    # ================= PASSWORD UPDATE =================
    if request.method == "POST":
        current = request.form.get("current_password")
        new = request.form.get("new_password")
        confirm = request.form.get("confirm_password")

        cursor.execute("SELECT password FROM users WHERE email=%s", (email,))
        db_user = cursor.fetchone()

        if not check_password_hash(db_user["password"], current):
            message = "Current password is incorrect"
        elif new != confirm:
            message = "New passwords do not match"
        else:
            hashed = generate_password_hash(new)
            cursor.execute(
                "UPDATE users SET password=%s WHERE email=%s",
                (hashed, email)
            )
            db.commit()
            message = "Password updated successfully"

    # ================= COMPLETED MODULES =================
    cursor.execute("""
        SELECT COUNT(*) AS completed_modules
        FROM (
            SELECT 
                m.id,
                COUNT(l.id) AS total_lessons,
                SUM(CASE WHEN lp.completed = 1 THEN 1 ELSE 0 END) AS completed_lessons
            FROM modules m
            LEFT JOIN lessons l ON m.id = l.module_id
            LEFT JOIN lesson_progress lp 
                ON l.id = lp.lesson_id AND lp.user_id = %s
            GROUP BY m.id
            HAVING total_lessons > 0
               AND total_lessons = completed_lessons
        ) AS completed_module_list
    """, (user_id,))

    completed_modules = cursor.fetchone()["completed_modules"]

    # ================= OTHER STATS =================

    # Lessons completed
    cursor.execute("""
        SELECT COUNT(*) AS total
        FROM lesson_progress
        WHERE user_id=%s AND completed=1
    """, (user_id,))
    lessons_completed = cursor.fetchone()["total"]

    # Average grade
    cursor.execute("""
        SELECT IFNULL(AVG((score/total)*100),0) AS avg_grade
        FROM module_quiz_results
        WHERE user_id=%s
    """, (user_id,))
    avg_grade = round(cursor.fetchone()["avg_grade"], 1)

    # ================= STATS DICTIONARY =================
    stats = {
        "courses": completed_modules,  # Now modules
        "quizzes": lessons_completed,
        "avg": avg_grade
    }

    cursor.close()
    db.close()

    return render_template(
        "student_profile.html",
        user=user,
        stats=stats,
        message=message
    )
    
@app.route("/chapter/<int:chapter_id>/notes")
def chapter_notes(chapter_id):
    if "user" not in session:
        return redirect(url_for("login"))

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM notes WHERE chapter_id=%s",
        (chapter_id,)
    )
    notes = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template("notes.html", notes=notes)

@app.route("/chapter/<int:chapter_id>/videos")
def chapter_videos(chapter_id):
    if "user" not in session:
        return redirect(url_for("login"))

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM videos WHERE chapter_id=%s",
        (chapter_id,)
    )
    videos = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template("videos.html", videos=videos)
def is_course_completed(user_id, course_id):
    cursor = mysql.connection.cursor()

    # Total lessons in that course
    cursor.execute("""
        SELECT COUNT(l.id)
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE m.course_id = %s
    """, (course_id,))
    total_lessons = cursor.fetchone()[0]

    # Completed lessons by that user
    cursor.execute("""
        SELECT COUNT(lp.lesson_id)
        FROM lesson_progress lp
        JOIN lessons l ON lp.lesson_id = l.id
        JOIN modules m ON l.module_id = m.id
        WHERE lp.user_id = %s
        AND m.course_id = %s
        AND lp.completed = 1
    """, (user_id, course_id))

    completed_lessons = cursor.fetchone()[0]

    cursor.close()

    return total_lessons > 0 and total_lessons == completed_lessons
@app.route("/course_internships")
def course_internships():
    if "user_id" not in session:
        return redirect(url_for("login"))

    course_id = request.args.get("id")
    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Check total lessons
    cursor.execute("""
        SELECT COUNT(l.id) AS total_lessons
        FROM lessons l
        JOIN modules m ON l.module_id = m.id
        WHERE m.course_id = %s
    """, (course_id,))
    total_lessons = cursor.fetchone()["total_lessons"]

    # Check completed lessons
    cursor.execute("""
        SELECT COUNT(lp.lesson_id) AS completed_lessons
        FROM lesson_progress lp
        JOIN lessons l ON lp.lesson_id = l.id
        JOIN modules m ON l.module_id = m.id
        WHERE lp.user_id = %s
        AND m.course_id = %s
        AND lp.completed = 1
    """, (user_id, course_id))
    completed_lessons = cursor.fetchone()["completed_lessons"]

    # Block if not 100%
    if total_lessons == 0 or completed_lessons != total_lessons:
        cursor.close()
        db.close()
        flash("Complete 100% course to unlock internships.")
        return redirect(url_for("course_detail", id=course_id))

    # Calculate progress
    if total_lessons > 0:
        course_progress = int((completed_lessons / total_lessons) * 100)
    else:
        course_progress = 0

    # Fetch internships
    cursor.execute("""
        SELECT * FROM internship_roles
        WHERE course_id = %s
    """, (course_id,))
    internships = cursor.fetchall()

    # 👇 THIS MUST BE INSIDE FUNCTION
    for internship in internships:

        # Check eligibility
        internship["eligible"] = (
            course_progress >= internship["min_score_required"]
        )

        # Check if already applied
        cursor.execute("""
            SELECT id FROM internship_applications
            WHERE user_id = %s AND internship_id = %s
        """, (user_id, internship["id"]))

        already_applied = cursor.fetchone()
        internship["applied"] = True if already_applied else False

    cursor.close()
    db.close()

    return render_template("internships.html", internships=internships)

@app.route("/generate_certificate/<int:course_id>")
def generate_certificate(course_id):

    if "user_id" not in session:
        return redirect(url_for("login"))

    user_id = session["user_id"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users WHERE id=%s", (user_id,))
    user = cursor.fetchone()

    cursor.execute("SELECT * FROM courses WHERE id=%s", (course_id,))
    course = cursor.fetchone()

    # Mark as generated
    cursor.execute("""
        UPDATE enrollments
        SET certificate_generated = 1
        WHERE user_id=%s AND course_id=%s
    """, (user_id, course_id))

    db.commit()

    cursor.close()
    db.close()

    return render_template("certificate.html", user=user, course=course)

    return redirect(url_for("course_detail", id=course_id))




# ============================================================================
# RUN APP
# ============================================================================

if __name__ == "__main__":
    app.run(debug=True)
