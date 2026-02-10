from flask import Flask, render_template, request, redirect, url_for, session,jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from db import get_db_connection
import os
import re
import google.generativeai as genai
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_DIR = os.path.join(BASE_DIR, "templates")

app = Flask(__name__, template_folder=TEMPLATE_DIR)
print("Flask is using templates from:", TEMPLATE_DIR)
print("Templates found:", os.listdir(TEMPLATE_DIR))


app.secret_key = "super-secret-key"
# 🔐 CONFIGURE GEMINI (PUT YOUR KEY HERE)
genai.configure(api_key="AIzaSyAn3MR4lo5TM6wN4jszTIKVg2VbU-Qy5I4")

model = genai.GenerativeModel("gemini-2.5-flash")


# ---------------- HOME ----------------
@app.route("/")
def home():
    return redirect(url_for("login"))


# ---------------- REGISTER ----------------
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
            session["user"] = user["email"]
            session["access_type"] = user["access_type"]  # Store access type in session
            
            # Redirect based on access type
            if user["access_type"] == "admin":
                return redirect(url_for("admin"))
            else:  # student or any other access type
                return redirect(url_for("dashboard"))
        else:
            return render_template(
                "login.html",
                error="Invalid email or password"
            )

    return render_template("login.html")
# ---------------- DASHBOARD ----------------
@app.route("/dashboard")
def dashboard():
    if "user" not in session:
        return redirect(url_for("login"))

    return render_template("dashboard.html", user=session["user"])


# ---------------- LOGOUT ----------------
@app.route("/logout")
def logout():
    session.pop("user", None)
    return redirect(url_for("login"))

#----------------- COURSE CATALOG ---------------------
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
         user=session["user"],
        courses=courses,
        subject=subject,
        level=level,
        sort=sort,
        search=search
    )

# ---------------- ADMIN PANEL ----------------
@app.route("/admin", methods=["GET", "POST"])
def admin():
    if "user" not in session:
        return redirect(url_for("login"))

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    message = None
    error = None

    # Handle POST request for adding faculty
    if request.method == "POST":
        faculty_name = request.form.get("fname")
        faculty_dept = request.form.get("fdept")
        faculty_email = request.form.get("fmail")

        # Validate input
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

    # Fetch Students
    cursor.execute("SELECT username as name, email, course FROM users")
    students = cursor.fetchall()

    # Fetch Faculties
    cursor.execute("SELECT name, department as dept, email FROM faculties")
    faculties = cursor.fetchall()

    # Fetch Courses
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
        error=error,
        
    )

#------------------COURSE DETAIL ---------------------------
@app.route("/course_detail")
def course_detail():
    if "user" not in session:
        return redirect(url_for("login"))

    course_id = request.args.get("id")

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM courses WHERE id=%s", (course_id,))
    course = cursor.fetchone()

    cursor.execute(
        "SELECT * FROM chapters WHERE course_id=%s ORDER BY chapter_no",
        (course_id,)
    )
    chapters = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "course_detail.html",
        course=course,
        user=session["user"],
        chapters=chapters
        
    )

@app.route("/chapter/<int:chapter_id>")
def chapter_content(chapter_id):
    if "user" not in session:
        return redirect(url_for("login"))

    return render_template("chapter_content.html", user=session["user"], chapter_id=chapter_id)


#------------------ ENROLL - INSERT -------------------------
@app.route("/enroll/<int:course_id>", methods=["POST"])
def enroll(course_id):
    if "user" not in session:
        return redirect(url_for("login"))

    try:
        db = get_db_connection()
        cursor = db.cursor()

        cursor.execute(
            "INSERT INTO enrollments (user_email, course_id) VALUES (%s, %s)",
            (session["user"], course_id)
        )

        db.commit()
        cursor.close()
        db.close()

    except:
        pass  # already enrolled

    return redirect(url_for("course_detail", id=course_id))

# ------------------ CHAPTER NOTES ------------------
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

    return render_template("notes.html",user=session["user"], notes=notes)


# ------------------ CHAPTER VIDEOS ------------------
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

    return render_template("videos.html", user=session["user"],videos=videos)

#----------------------- CHATBOT ---------------------------
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

    return render_template("chatbot.html",user=session["user"], chats=chats)
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
        # 🔥 Gemini response
        response = model.generate_content(prompt)
        reply = response.text

        # 🔥 SAVE TO DATABASE
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


# -------------------- PROFILE -----------------------------
@app.route("/profile", methods=["GET", "POST"])
def profile():
    if "user" not in session:
        return redirect(url_for("login"))

    email = session["user"]

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # GET USER INFO
    cursor.execute("SELECT username AS name, email FROM users WHERE email=%s", (email,))
    user = cursor.fetchone()

    message = None

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

    # DUMMY STATS (can connect DB later)
    stats = {
        "courses": 3,
        "quizzes": 8,
        "avg": 78,
        "streak": 5
    }

    cursor.close()
    db.close()

    return render_template(
        "student_profile.html",
        user=user,
        stats=stats,
        message=message
    )


# ---------------- RUN APP ----------------
if __name__ == "__main__":
    app.run()



