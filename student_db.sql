-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2026 at 09:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_history`
--

CREATE TABLE `chatbot_history` (
  `id` int(11) NOT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatbot_history`
--

INSERT INTO `chatbot_history` (`id`, `user_email`, `question`, `answer`, `created_at`) VALUES
(22, 'kshatriyayash19@gmail.com', 'Hey Ai', 'Hey there! How can I help you today?', '2026-02-10 08:28:27'),
(23, 'kshatriyayash19@gmail.com', 'What is DSA..explain in short', 'DSA stands for **Data Structures and Algorithms**.\n\nIn short:\n\n*   **Data Structures** are specialized ways to organize and store data in a computer so that it can be accessed and modified efficiently (e.g., arrays, linked lists, trees, graphs).\n*   **Algorithms** are step-by-step procedures or formulas for solving a problem or accomplishing a task (e.g., sorting data, searching for an item, finding the shortest path).\n\nTogether, DSA is the fundamental study of how to store data effectively and how to write efficient procedures to manipulate that data to solve computational problems. It\'s a core skill for any programmer to write optimized and high-performing code.', '2026-02-10 08:28:45'),
(24, 'kshatriyayash19@gmail.com', 'Hey explain dsa in detail', 'Hey there! Absolutely, I can help you understand Data Structures and Algorithms (DSA) in detail. Think of DSA as the fundamental building blocks and techniques that every computer scientist or programmer uses to write efficient and effective code.\n\nLet\'s break it down:\n\n---\n\n## What is DSA? (Data Structures and Algorithms)\n\nAt its core, DSA is about two main things:\n\n1.  **Data Structures:** How you organize and store data.\n2.  **Algorithms:** How you process and manipulate that data to solve problems.\n\nThey are two sides of the same coin. You can\'t have good algorithms without thinking about how your data is structured, and you usually choose a data structure based on the kind of operations your algorithms need to perform efficiently.\n\n---\n\n## Part 1: Data Structures\n\nImagine you have a messy room. Data structures are like the different ways you could organize your belongings – a bookshelf for books, a wardrobe for clothes, a filing cabinet for documents, etc. Each method has its pros and cons for finding, adding, or removing items.\n\n**Definition:** A Data Structure is a particular way of organizing data in a computer so that it can be accessed and modified efficiently.\n\nHere are some of the most common and fundamental data structures:\n\n1.  **Arrays:**\n    *   **Concept:** A collection of items stored at contiguous (next to each other) memory locations. Each item has an index.\n    *   **Analogy:** A row of numbered mailboxes.\n    *   **Pros:** Very fast access to any element if you know its index. Efficient memory usage.\n    *   **Cons:** Fixed size (usually), adding/removing elements in the middle can be slow as you might need to shift many other elements.\n\n2.  **Linked Lists:**\n    *   **Concept:** A sequence of nodes, where each node contains data and a pointer (or reference) to the next node in the sequence.\n    *   **Analogy:** A treasure hunt where each clue tells you where to find the next clue.\n    *   **Types:** Singly Linked List (one direction), Doubly Linked List (two directions), Circular Linked List.\n    *   **Pros:** Dynamic size (can grow/shrink easily), efficient insertion/deletion anywhere in the list (once you find the spot).\n    *   **Cons:** Slower access to elements (you have to start from the beginning and traverse), uses more memory than arrays (for pointers).\n\n3.  **Stacks:**\n    *   **Concept:** A \"Last-In, First-Out\" (LIFO) data structure. Think of a stack of plates.\n    *   **Analogy:** A stack of plates – you can only add a new plate to the top, and you can only remove the top plate.\n    *   **Operations:** `push` (add to top), `pop` (remove from top), `peek` (look at top), `isEmpty`.\n    *   **Use Cases:** Function call management (recursion), undo/redo features, browser history.\n\n4.  **Queues:**\n    *   **Concept:** A \"First-In, First-Out\" (FIFO) data structure. Think of a line at a supermarket.\n    *   **Analogy:** A line of people waiting for a bus – the first person in line is the first to get on the bus.\n    *   **Operations:** `enqueue` (add to rear), `dequeue` (remove from front), `peek` (look at front), `isEmpty`.\n    *   **Use Cases:** Task scheduling, print job queues, breadth-first search.\n\n5.  **Trees:**\n    *   **Concept:** A hierarchical data structure where data is organized in nodes connected by edges. It starts with a root node, and each node can have child nodes.\n    *   **Analogy:** A family tree, or an organizational chart.\n    *   **Types:**\n        *   **Binary Tree:** Each node has at most two children (left and right).\n        *   **Binary Search Tree (BST):** A special binary tree where for any node, all values in its left subtree are smaller than its value, and all values in its right subtree are larger. This allows for very efficient searching.\n        *   **Balanced Trees (AVL, Red-Black):** Self-balancing BSTs that ensure operations remain efficient even with many insertions/deletions.\n    *   **Use Cases:** File systems, databases, syntax trees (compilers).\n\n6.  **Graphs:**\n    *   **Concept:** A collection of nodes (vertices) and edges that connect pairs of nodes. Unlike trees, nodes can have any number of connections and can even form cycles.\n    *   **Analogy:** A map of cities connected by roads, or a social network.\n    *   **Types:** Directed (one-way connections), Undirected (two-way connections), Weighted (edges have costs).\n    *   **Use Cases:** Social networks, GPS and shortest path algorithms, network routing.\n\n7.  **Hash Tables (or Hash Maps):**\n    *   **Concept:** A data structure that stores key-value pairs. It uses a `hash function` to compute an index into an array of buckets or slots, from which the desired value can be found.\n    *   **Analogy:** A dictionary where you look up a word (key) to find its definition (value), but instead of alphabetical order, there\'s a magical function that tells you exactly which page to go to.\n    *   **Pros:** Extremely fast average-case time for insertions, deletions, and lookups (O(1)).\n    *   **Cons:** Worst-case performance can be slow if there are many \"collisions\" (multiple keys mapping to the same index).\n    *   **Use Cases:** Dictionaries/maps in programming languages, caching, database indexing.\n\n---\n\n## Part 2: Algorithms\n\nIf data structures are about organizing your stuff, algorithms are the instructions you follow to *do* something with that stuff – like finding a specific book, sorting your clothes, or finding the shortest route to a friend\'s house.\n\n**Definition:** An Algorithm is a set of well-defined, step-by-step instructions to solve a particular problem or perform a computation.\n\nHere are some common types and categories of algorithms:\n\n1.  **Searching Algorithms:**\n    *   **Concept:** Finding a specific item within a data structure.\n    *   **Examples:**\n        *   **Linear Search:** Checks each item one by one until it finds the target (simple, but slow for large datasets).\n        *   **Binary Search:** Requires a sorted list. It repeatedly divides the search interval in half until the target is found or the interval is empty (much faster for large, sorted datasets).\n    *   **Use Cases:** Finding a contact in your phone, looking up a word in a dictionary.\n\n2.  **Sorting Algorithms:**\n    *   **Concept:** Arranging items in a specific order (ascending, descending, alphabetical, etc.).\n    *   **Examples:**\n        *   **Bubble Sort, Selection Sort, Insertion Sort:** Simpler, less efficient for large datasets (O(n^2)). Good for small or nearly sorted lists.\n        *   **Merge Sort, Quick Sort:** More complex, but much more efficient for large datasets (O(n log n) average case). These are commonly used in practice.\n        *   **Heap Sort:** Also O(n log n), uses a Heap data structure.\n    *   **Use Cases:** Organizing search results, displaying lists of items in order.\n\n3.  **Recursion:**\n    *   **Concept:** A technique where a function calls itself to solve smaller instances of the same problem.\n    *   **Analogy:** A set of Russian nesting dolls, where each doll contains a smaller version of itself.\n    *   **Use Cases:** Tree/Graph traversals, calculating factorials, generating permutations.\n\n4.  **Dynamic Programming:**\n    *   **Concept:** A method for solving complex problems by breaking them down into simpler subproblems and storing the results of those subproblems to avoid redundant calculations.\n    *   **Analogy:** Instead of recalculating every step on a long journey each time, you remember the best path from each checkpoint you\'ve visited.\n    *   **Use Cases:** Finding the shortest path, knapsack problem, string matching, many optimization problems.\n\n5.  **Greedy Algorithms:**\n    *   **Concept:** Makes the locally optimal choice at each step with the hope of finding a global optimum. It doesn\'t always guarantee the best overall solution, but it\'s often simpler and faster.\n    *   **Analogy:** Always picking the biggest piece of cake, hoping you end up with the most cake overall.\n    *   **Use Cases:** Dijkstra\'s shortest path algorithm (for certain conditions), Kruskal\'s or Prim\'s for Minimum Spanning Trees, activity selection problem.\n\n6.  **Graph Algorithms:**\n    *   **Concept:** Algorithms specifically designed to work with graph data structures.\n    *   **Examples:**\n        *   **Graph Traversal (BFS - Breadth-First Search, DFS - Depth-First Search):** Ways to visit every node in a graph.\n        *   **Shortest Path Algorithms (Dijkstra\'s, Bellman-Ford, Floyd-Warshall):** Finding the shortest path between two nodes.\n        *   **Minimum Spanning Tree (Prim\'s, Kruskal\'s):** Finding a subset of edges that connects all vertices with the minimum total edge weight.\n    *   **Use Cases:** GPS navigation, social network analysis, routing in computer networks.\n\n---\n\n## Why is DSA Important?\n\n1.  **Efficiency:** It\'s not enough for code to just *work*. It also needs to be efficient. DSA helps you write code that runs faster and uses less memory.\n2.  **Problem-Solving Skills:** Learning DSA trains your brain to think systematically about problems, break them down, and choose the most appropriate tools to solve them.\n3.  **Foundation for Advanced Topics:** Concepts from DSA are foundational for understanding operating systems, databases, artificial intelligence, machine learning, and more.\n4.  **Coding Interviews:** Almost every tech company (especially major ones) uses DSA questions to assess a candidate\'s problem-solving abilities and technical chops.\n5.  **Better Software:** Understanding DSA allows you to design and build more robust, scalable, and performant software systems.\n\n---\n\n## Key Concept: Time and Space Complexity (Big O Notation)\n\nWhen we talk about \"efficiency\" in DSA, we\'re primarily talking about **Time Complexity** and **Space Complexity**.\n\n*   **Time Complexity:** How the running time of an algorithm grows with the input size.\n*   **Space Complexity:** How the memory usage of an algorithm grows with the input size.\n\nWe use **Big O Notation** (e.g., O(1), O(log n), O(n), O(n log n), O(n^2), O(2^n)) to describe these complexities. It gives an upper bound on the growth rate, focusing on the worst-case scenario.\n\n*   **O(1) - Constant:** The time/space doesn\'t change regardless of input size (e.g., accessing an array element by index).\n*   **O(n) - Linear:** Time/space grows proportionally with input size (e.g., linear search).\n*   **O(n log n) - Log-Linear:** Very efficient for sorting large datasets (e.g., Merge Sort).\n*   **O(n^2) - Quadratic:** Time/space grows quadratically (e.g., nested loops, bubble sort). Less efficient for large inputs.\n\nUnderstanding Big O is crucial because it helps you compare different algorithms for the same problem and choose the most suitable one for your needs.\n\n---\n\n## How to Approach Learning DSA:\n\n1.  **Start with Fundamentals:** Master arrays, linked lists, stacks, queues, and their basic operations.\n2.  **Understand Big O:** Get a solid grasp of time and space complexity.\n3.  **Pick a Language:** While the concepts are language-agnostic, you\'ll need a language (Python, Java, C++, JavaScript) to implement them.\n4.  **Practice, Practice, Practice:** The only way to truly learn is by solving problems. Start with easy problems on platforms like LeetCode, HackerRank, AlgoExpert, or Codeforces.\n5.  **Visualize:** Use online tools or draw diagrams to understand how data structures and algorithms work step-by-step.\n6.  **Don\'t Get Discouraged:** DSA can be challenging, but persistence pays off. Break down problems, ask for help, and celebrate small victories.\n\n---\n\nIn essence, DSA is like learning the fundamental physics and engineering principles before you start building bridges or skyscrapers. It gives you the knowledge to build strong, stable, and efficient software. Good luck on your learning journey!', '2026-02-10 09:09:06'),
(25, 'thakershivang1@gmail.com', 'Hey', 'Hey there! How can I help you today?', '2026-02-20 17:37:05'),
(26, 'thakershivang1@gmail.com', 'Hii', 'Hi there! How can I help you today?', '2026-02-20 17:40:29'),
(27, 'kshatriyayash19@gmail.com', 'what is oops in java', '**OOPS** stands for **Object-Oriented Programming System** (or Paradigm). It\'s a programming methodology or style that structures programs around **objects** rather than just functions and data.\n\nIn simpler terms, OOPS is a way of designing software that models real-world entities. Instead of focusing on \"what to do,\" it focuses on \"who does what.\"\n\nJava is built from the ground up to be an Object-Oriented language, meaning almost everything you do in Java revolves around objects and classes.\n\n---\n\nHere\'s a breakdown of the core concepts of OOPS in Java:\n\n1.  **Objects:**\n    *   **Definition:** An object is a real-world entity. It\'s an instance of a class. It has a **state** (data/attributes) and **behavior** (actions/methods).\n    *   **Example:** A `Car` object might have a state (color, make, model, speed) and behavior (accelerate(), brake(), turn()).\n    *   **In Java:** When you create `new Car()`, you are creating an object.\n\n2.  **Classes:**\n    *   **Definition:** A class is a blueprint or a template from which objects are created. It defines the common properties (attributes) and behaviors (methods) that all objects of that type will have. It\'s a logical entity, not a physical one.\n    *   **Example:** The `Car` class defines what all cars *will* have (color, make) and what all cars *can do* (accelerate, brake), but it\'s not a specific car itself.\n    *   **In Java:** You define a class using the `class` keyword:\n        ```java\n        class Car {\n            String color;\n            String make;\n\n            void accelerate() {\n                // code to increase speed\n            }\n        }\n        ```\n\n---\n\n### The Four Pillars of OOPS\n\nThese are the fundamental principles that define Object-Oriented Programming:\n\n1.  **Encapsulation:**\n    *   **Concept:** Bundling the data (attributes) and the methods that operate on that data within a single unit (the class). It also involves hiding the internal state of an object and requiring all interaction to be done through the object\'s methods.\n    *   **Analogy:** A pill capsule contains medicine; you don\'t see the individual chemicals inside. Similarly, an object hides its internal workings.\n    *   **In Java:** Achieved by declaring variables (attributes) as `private` and providing public `getter` and `setter` methods to access and modify them. This protects data from external, uncontrolled access.\n\n2.  **Inheritance:**\n    *   **Concept:** The mechanism by which one class (subclass/child class) acquires the properties and behaviors (fields and methods) of another class (superclass/parent class). It promotes code reusability and establishes a \"is-a\" relationship.\n    *   **Analogy:** A child inherits traits from its parents. A \"SportsCar\" *is a* \"Car\" and inherits all its general car properties.\n    *   **In Java:** Achieved using the `extends` keyword.\n        ```java\n        class Vehicle { // Superclass\n            void drive() { /* ... */ }\n        }\n\n        class Car extends Vehicle { // Subclass\n            // Car inherits drive() method from Vehicle\n            void honk() { /* ... */ }\n        }\n        ```\n\n3.  **Polymorphism:**\n    *   **Concept:** Meaning \"many forms.\" It\'s the ability of an object to take on many forms, or for a single interface to represent different underlying implementations.\n    *   **Analogy:** A person can be a parent, an employee, a student – performing different roles based on the context. A \"Shape\" object could be a `Circle`, `Square`, or `Triangle`, and each would have its own way of drawing itself, even though you call a generic `draw()` method.\n    *   **In Java:**\n        *   **Method Overloading (Compile-time/Static Polymorphism):** Methods with the same name but different parameters within the same class.\n        *   **Method Overriding (Runtime/Dynamic Polymorphism):** A subclass provides a specific implementation for a method that is already defined in its superclass.\n\n4.  **Abstraction:**\n    *   **Concept:** Hiding complex implementation details and showing only the essential features of an object. It focuses on \"what an object does\" rather than \"how it does it.\"\n    *   **Analogy:** When you drive a car, you use the steering wheel, accelerator, and brake. You don\'t need to know the intricate details of how the engine works to drive it.\n    *   **In Java:** Achieved using `abstract` classes and `interfaces`. Abstract classes can have abstract methods (methods without an implementation) that must be implemented by subclasses. Interfaces define a contract of methods that a class must implement.\n\n---\n\n**Why OOPS in Java (Benefits)?**\n\n*   **Modularity:** Breaks down complex systems into smaller, manageable objects.\n*   **Reusability:** Code (classes) can be reused in different parts of the program or in different projects through inheritance.\n*   **Maintainability:** Easier to debug, modify, and update code because changes in one object don\'t necessarily affect others.\n*   **Scalability:** Easier to add new features or extend existing ones.\n*   **Flexibility:** Adaptable to changes in requirements.\n*   **Security:** Encapsulation helps protect data.\n\nIn essence, OOPS in Java provides a powerful and organized way to structure programs, making them more robust, flexible, and easier to manage, especially for large-scale applications.', '2026-02-20 21:57:52'),
(28, 'kshatriyayash19@gmail.com', 'ok', 'Okay! How can I help you today?', '2026-02-20 21:58:06'),
(29, 'kshatriyayash19@gmail.com', 'hello', 'Hello! How can I help you today?', '2026-02-21 06:53:39'),
(30, 'kshatriyayash19@gmail.com', 'How to use academix', 'Academix sounds like a valuable tool! To give you the best and most accurate advice, could you tell me a little more about what \"Academix\" refers to in your specific context?\n\n\"Academix\" isn\'t a universally known platform, so it likely refers to a specific system or resource used by your university, department, or a particular course. It could be:\n\n1.  **A Learning Management System (LMS):** Like Canvas, Blackboard, Moodle, or Brightspace, where you access course materials, submit assignments, view grades, and communicate with professors.\n2.  **A Student Portal or Information System:** Where you manage your registration, financial aid, personal details, and view official university announcements.\n3.  **A Library Database or Research Tool:** A platform for finding academic articles, journals, books, or managing citations.\n4.  **A Department-Specific Software:** A specialized tool used only within a particular faculty or for specific academic tasks (e.g., lab simulations, data analysis).\n5.  **An Academic Writing or Productivity Tool:** For improving writing, collaboration, or project management.\n\n**In the meantime, here\'s how you generally figure out how to use any new academic platform:**\n\n1.  **Check Your University\'s Website/Portal:**\n    *   Look for a search bar and type \"Academix.\"\n    *   Check sections like \"Current Students,\" \"Academic Resources,\" \"IT Support,\" or \"Library.\"\n    *   There\'s often a dedicated page with an overview, login instructions, and basic tutorials.\n\n2.  **Consult Your Course Syllabus:**\n    *   If Academix is used for a specific course, your professor will usually mention it in the syllabus, along with instructions or links to resources.\n\n3.  **Contact Your University\'s IT Help Desk or Support:**\n    *   This is often the quickest and most direct way to get information and troubleshooting help. They can tell you exactly what Academix is and how to access it.\n\n4.  **Ask Your Professor or TA:**\n    *   If it\'s related to a course, they are the best resource for how they expect you to use it for their class.\n\n5.  **Reach Out to Your University Library Staff:**\n    *   If you suspect it\'s a research-related tool, librarians are experts in guiding students through various databases and academic resources.\n\n6.  **Look for Tutorials or FAQs within the Platform Itself:**\n    *   Once you gain access, most academic platforms have built-in help sections, user guides, or introductory videos.\n\n**Once you know what \"Academix\" is (e.g., \"It\'s our university\'s new LMS\" or \"It\'s a specific research database\"), I can give you much more targeted advice!**', '2026-02-21 06:54:44'),
(31, 'kshatriyayash19@gmail.com', 'hii how are ypuy!!', 'Hi there! I\'m doing great, thank you for asking!\n\nHow are *you* doing today?', '2026-02-21 07:39:55'),
(32, 'kshatriyayash19@gmail.com', 'exlain django', 'Okay, let\'s break down Django in a way that\'s easy to understand!\n\n---\n\n**What is Django?**\n\nImagine you want to build a house. You *could* start by making your own bricks, cutting your own timber, designing every single pipe and wire. It would take forever!\n\nNow, imagine a kit that gives you a strong foundation, pre-built walls, a plumbing system, an electrical grid, and even a set of tools to put it all together quickly and efficiently.\n\n**Django is like that kit, but for building websites and web applications.**\n\nMore formally:\n\n**Django is a high-level Python web framework that enables rapid development of secure and maintainable websites.**\n\nLet\'s unpack that:\n\n*   **Python Web Framework:**\n    *   **Python:** It\'s built using the Python programming language, which is known for its readability and versatility. This means you write your website\'s logic in Python.\n    *   **Web Framework:** A framework is a collection of tools, libraries, and conventions that provides a structure and foundation for building applications. Instead of starting from scratch every time, Django gives you a head start by handling many of the common tasks involved in web development.\n\n*   **High-level:** It abstracts away many of the complex, low-level details of web development, allowing you to focus on the unique features of your application.\n\n*   **Rapid Development:** Django\'s philosophy (often summarized as \"Don\'t Repeat Yourself\" or DRY) and its \"batteries-included\" approach mean you can build complex applications much faster than if you were coding everything from scratch.\n\n*   **Secure and Maintainable:** Django is built with security in mind, providing protections against common vulnerabilities like SQL injection and cross-site scripting. Its structured approach also makes applications easier to maintain and scale over time.\n\n---\n\n**What Does Django Do? (Key Features / Why Use It?)**\n\nDjango helps you build the \"backend\" of a website – the server-side logic that users don\'t directly see but that powers everything. It handles tasks like:\n\n1.  **Connecting to Databases (ORM - Object-Relational Mapper):**\n    *   You don\'t need to write raw SQL code to interact with your database (e.g., to save user data, retrieve blog posts). Django\'s ORM lets you do it all with Python code, which is much easier and safer.\n\n2.  **Handling URLs and Routing:**\n    *   When a user types `yourwebsite.com/blog/my-post`, Django knows which piece of code should handle that request and display the correct blog post.\n\n3.  **User Authentication & Authorization:**\n    *   It provides a robust system for handling user accounts, logins, passwords, permissions (who can do what), and security.\n\n4.  **Automatic Admin Interface:**\n    *   One of Django\'s killer features! With just a few lines of code, you get a fully functional, professional-looking admin panel to manage your website\'s content (e.g., add new products, edit blog posts, manage users).\n\n5.  **Templating System:**\n    *   It helps you dynamically generate HTML pages using \"templates,\" so you can separate your website\'s design from its underlying logic.\n\n6.  **\"Batteries Included\":**\n    *   This is a famous Django motto. It means Django comes with almost everything you might need built-in: a testing framework, caching, session management, forms handling, and much more. You rarely need to add third-party libraries for basic functionality.\n\n---\n\n**How Does Django Work? (The MVT Pattern)**\n\nDjango loosely follows a pattern called **MVT (Model-View-Template)**, which is similar to the more common MVC (Model-View-Controller) pattern.\n\n*   **Model:** This is where you define the structure of your data (e.g., what fields does a \"User\" have? What about a \"Blog Post\"?). It\'s the part that interacts with your database.\n*   **View:** This is the \"business logic\" of your application. It decides what data to retrieve from the Model, processes it, and then sends it to the Template. Think of it as the brain that responds to requests.\n*   **Template:** This is the part that displays the data to the user, usually as an HTML page. It\'s the user interface layer.\n\n---\n\n**Who Uses Django?**\n\nMany big, popular websites and organizations use Django, proving its scalability and reliability:\n\n*   **Instagram**\n*   **Spotify**\n*   **Pinterest**\n*   **NASA**\n*   **The Washington Post**\n*   **Disqus**\n\n---\n\n**In a Nutshell:**\n\nDjango is a powerful, versatile, and developer-friendly framework that makes building complex, secure, and maintainable web applications with Python much faster and easier. If you want to build a website or web service, Django provides a robust and efficient path to get there.', '2026-02-21 07:40:26'),
(33, 'kshatriyayash19@gmail.com', 'explain oops in short', 'OOP (Object-Oriented Programming) is a programming paradigm that organizes software design around **\"objects\"** rather than just functions and logic.\n\nIn short:\n\n*   **Objects** are self-contained units that bundle **data** (attributes/properties) and the **behaviors** (methods/functions) that operate on that data.\n*   The goal is to model real-world entities and their interactions within your code.\n*   **Benefits:** It promotes code **modularity**, **reusability**, **maintainability**, and makes complex systems easier to manage and scale.\n*   **Key Principles (Pillars):** Encapsulation, Inheritance, Polymorphism, and Abstraction are the core concepts that define OOP.', '2026-02-21 07:41:36'),
(34, 'thakershivang1@gmail.com', 'what is oops', 'OOPS stands for **Object-Oriented Programming System** (or sometimes **Object-Oriented Programming Paradigm**).\n\nIt\'s a fundamental programming approach that organizes software design around **objects** rather than just functions and logic. In OOPS, everything is viewed as an object, which is a self-contained unit that bundles both **data** (attributes or properties) and the **methods** (functions or behaviors) that operate on that data.\n\n**To understand OOPS, think of it this way:**\n\nImagine you\'re building a system for a car dealership.\n*   In traditional procedural programming, you might have separate functions like `create_car()`, `paint_car()`, `start_car()`, and separate data structures for `Car_A_Color`, `Car_B_Speed`, etc. It can get messy and hard to manage as the system grows.\n*   In OOPS, you would define a \"Car\" **object**. Each `Car` object would contain:\n    *   **Data/Attributes:** `color`, `make`, `model`, `speed`, `fuelLevel`.\n    *   **Methods/Behaviors:** `start()`, `accelerate()`, `brake()`, `refuel()`.\n    All related car information and actions are kept together within that `Car` object.\n\n**Core Concepts (The Four Pillars of OOPS):**\n\n1.  **Encapsulation:**\n    *   **What it is:** Bundling data (attributes) and methods (functions) that operate on the data into a single unit (the object), and hiding the internal state of the object from the outside.\n    *   **Analogy:** Think of a pill capsule. It contains various ingredients (data), and you take the pill (call a method) to get an effect, but you don\'t need to know the exact chemical interactions happening inside. You interact with it as a single unit.\n\n2.  **Inheritance:**\n    *   **What it is:** Allows a new class (child/subclass) to acquire the properties and behaviors (data and methods) of an existing class (parent/superclass). This promotes code reusability.\n    *   **Analogy:** Just like a child inherits traits from their parents, a \"SportsCar\" class might inherit all the general properties and methods from a \"Car\" class (like `start()`, `accelerate()`) and then add its own unique features (like `turboBoost()`).\n\n3.  **Polymorphism:**\n    *   **What it is:** Means \"many forms.\" It allows objects of different classes to be treated as objects of a common superclass, and allows a single interface (method name) to be used for different underlying forms (implementations).\n    *   **Analogy:** You might have a \"Shape\" class with a `draw()` method. A \"Circle\" object will draw a circle when `draw()` is called, and a \"Square\" object will draw a square when its `draw()` method is called. The `draw()` method takes \"many forms\" depending on the specific shape object.\n\n4.  **Abstraction:**\n    *   **What it is:** Focusing on showing only essential features and hiding the complex implementation details. It simplifies the view of a complex system.\n    *   **Analogy:** When you drive a car, you use the steering wheel, pedals, and gear stick (the essential features). You don\'t need to know the intricate details of how the engine works, how the fuel is injected, or how the braking system engages to drive the car. Those complex details are *abstracted away*.\n\n**Why is OOPS popular?**\n\n*   **Modularity:** Code is organized into self-contained objects, making it easier to understand and manage.\n*   **Reusability:** Inheritance allows you to reuse existing code, saving development time.\n*   **Maintainability:** Changes in one part of the code are less likely to affect other parts, making debugging and updates easier.\n*   **Scalability:** Easier to add new features and expand the system.\n*   **Security:** Encapsulation helps protect data from unintended external access.\n\nMany popular programming languages like Java, Python, C++, C#, Ruby, and JavaScript (among others) are object-oriented or support OOPS principles.', '2026-02-21 07:50:47'),
(35, 'thakershivang1@gmail.com', 'hey', 'Hey there! How can I help you today?', '2026-02-21 08:06:08');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender_type` enum('student','faculty') NOT NULL,
  `message` text NOT NULL,
  `attachment_url` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `conversation_id`, `sender_id`, `sender_type`, `message`, `attachment_url`, `is_read`, `read_at`, `created_at`) VALUES
(1, 1, 10, 'student', 'Hello Sir, I need help understanding recursion. Can you explain the concept with a simple example?', NULL, 1, NULL, '2026-02-13 18:54:17'),
(2, 1, 7, 'faculty', 'Hi! Sure, let me explain recursion with the factorial example. Recursion is when a function calls itself to solve smaller subproblems.', NULL, 1, NULL, '2026-02-13 18:54:17'),
(3, 1, 10, 'student', 'Thank you! Could you also explain what happens when we don\'t have a base case?', NULL, 0, NULL, '2026-02-13 18:54:17'),
(4, 2, 9, 'student', 'I\'m stuck with BST delete operation. How do we handle the case when the node has two children?', NULL, 0, NULL, '2026-02-13 18:54:17'),
(5, 4, 17, 'student', 'how to learn DSA ', NULL, 0, NULL, '2026-02-13 19:37:22');

-- --------------------------------------------------------

--
-- Table structure for table `chat_notifications`
--

CREATE TABLE `chat_notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `message_id` int(11) DEFAULT NULL,
  `notification_type` enum('new_message','doubt_assigned','doubt_resolved','status_changed') NOT NULL,
  `message` varchar(500) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_notifications`
--

INSERT INTO `chat_notifications` (`id`, `user_id`, `conversation_id`, `message_id`, `notification_type`, `message`, `is_read`, `read_at`, `created_at`) VALUES
(1, 7, 1, 3, 'new_message', 'New message from Student in \"Understanding Recursion in Java\"', 0, NULL, '2026-02-13 18:54:36'),
(2, 7, 2, 4, 'new_message', 'New message from Student in \"Binary Search Tree Implementation\"', 0, NULL, '2026-02-13 18:54:36'),
(3, 10, 1, 2, 'new_message', 'Faculty replied to your doubt \"Understanding Recursion in Java\"', 1, NULL, '2026-02-13 18:54:36');

-- --------------------------------------------------------

--
-- Table structure for table `conversation_participants`
--

CREATE TABLE `conversation_participants` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('student','faculty','admin') NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conversation_participants`
--

INSERT INTO `conversation_participants` (`id`, `conversation_id`, `user_id`, `role`, `joined_at`, `last_seen_at`, `is_active`) VALUES
(1, 1, 10, 'student', '2026-02-13 18:54:50', '2026-02-13 18:54:50', 1),
(2, 1, 7, 'faculty', '2026-02-13 18:54:50', '2026-02-13 18:54:50', 1),
(3, 2, 9, 'student', '2026-02-13 18:54:50', '2026-02-13 18:54:50', 1),
(4, 2, 7, 'faculty', '2026-02-13 18:54:50', NULL, 1),
(5, 3, 10, 'student', '2026-02-13 18:54:50', '2026-02-13 18:54:50', 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `level` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `faculty_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `title`, `subject`, `level`, `description`, `rating`, `faculty_id`) VALUES
(1, 'Python Programming', 'Computer Science', 'Beginner', 'Learn Python from scratch', 4.7, 1),
(2, 'Data Structures', 'Computer Science', 'Intermediate', 'DSA concepts in depth', 4.5, 2),
(3, 'Machine Learning', 'Computer Science', 'Advanced', 'ML algorithms & projects', 4.8, 2),
(5, 'Machine Learning Basics', 'Computer Science', 'Intermediate', 'Learn ML fundamentals from scratch', 3.8, 2),
(6, 'Introduction to HTML, CSS and JavaScript', 'Computer Science', 'Beginner', 'Learn frontend web development from scratch including HTML, CSS and JavaScript.', 4.9, 3),
(7, 'Introduction to Java', 'Computer Science', 'Beginner', 'Learn Java programming from scratch including fundamentals, operators, control flow, and core concepts.', 4.5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `doubt_conversations`
--

CREATE TABLE `doubt_conversations` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `attachment_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resolved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doubt_conversations`
--

INSERT INTO `doubt_conversations` (`id`, `student_id`, `faculty_id`, `subject`, `description`, `status`, `priority`, `attachment_url`, `created_at`, `updated_at`, `resolved_at`) VALUES
(1, 10, 7, 'Understanding Recursion in Java', 'I am having trouble understanding how recursion works, especially with the base case and recursive calls.', 'in_progress', 'high', NULL, '2026-02-13 18:53:53', '2026-02-13 18:53:53', NULL),
(2, 9, 7, 'Binary Search Tree Implementation', 'Need help implementing BST insert and delete operations in Python.', 'open', 'medium', NULL, '2026-02-13 18:53:53', '2026-02-13 18:53:53', NULL),
(3, 10, NULL, 'Time Complexity Analysis', 'How do I analyze the time complexity of nested loops?', 'open', 'low', NULL, '2026-02-13 18:53:53', '2026-02-13 18:53:53', NULL),
(4, 17, NULL, 'what is DSA', 'how to learn DSA ', 'open', 'medium', NULL, '2026-02-13 19:37:22', '2026-02-13 19:37:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `enrolled_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `certificate_generated` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `course_id`, `enrolled_at`, `user_id`, `certificate_generated`) VALUES
(1, 1, '2026-02-05 06:11:20', 7, 0),
(2, 1, '2026-02-08 10:28:01', 9, 0),
(3, 2, '2026-02-08 10:31:38', 9, 0),
(4, 2, '2026-02-13 08:29:16', 10, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE `faculties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculties`
--

INSERT INTO `faculties` (`id`, `name`, `email`, `department`) VALUES
(1, 'Dr. Amit Sharma', 'amit.sharma@academix.com', 'Computer Science'),
(2, 'Prof. Neha Verma', 'neha.verma@academix.com', 'Computer Science'),
(3, 'Mr. Raj Malhotra', 'raj.malhotra@academix.com', 'Web Development');

-- --------------------------------------------------------

--
-- Table structure for table `internship_applications`
--

CREATE TABLE `internship_applications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `internship_id` int(11) NOT NULL,
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internship_applications`
--

INSERT INTO `internship_applications` (`id`, `user_id`, `internship_id`, `applied_at`, `status`) VALUES
(1, 8, 1, '2026-02-18 16:50:15', 'Pending'),
(2, 10, 1, '2026-02-20 01:37:01', 'Pending'),
(3, 10, 17, '2026-02-20 12:44:20', 'Pending'),
(4, 10, 15, '2026-02-21 05:42:35', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `internship_roles`
--

CREATE TABLE `internship_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(150) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `stipend` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `min_score_required` int(11) DEFAULT 60,
  `course_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `job_type` varchar(50) DEFAULT NULL,
  `stipend_amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internship_roles`
--

INSERT INTO `internship_roles` (`id`, `role_name`, `company_name`, `location`, `stipend`, `description`, `min_score_required`, `course_id`, `created_at`, `job_type`, `stipend_amount`) VALUES
(15, 'Frontend Developer Intern', 'Google', 'Bangalore, India', '₹25,000 / month', 'Build scalable UI systems with modern frameworks.', 70, 1, '2026-02-20 12:24:50', 'Full-time', 25000),
(16, 'Backend Developer Intern', 'Amazon', 'Remote (India)', '₹30,000 / month', 'Develop REST APIs and cloud-based backend systems.', 75, 1, '2026-02-20 12:24:50', 'Full-time', 30000),
(17, 'Full Stack Developer Intern', 'Microsoft', 'Hyderabad, India', '₹28,000 / month', 'Work on end-to-end product features.', 80, 1, '2026-02-20 12:24:50', 'Full-time', 28000),
(18, 'Data Analyst Intern', 'Spotify', 'Mumbai, India', '₹22,000 / month', 'Work with large datasets and visualization tools.', 65, 2, '2026-02-20 12:24:50', 'Part-time', 22000),
(19, 'Software Engineer Intern', 'Adobe', 'Remote (India)', '₹26,000 / month', 'Build scalable enterprise systems.', 75, 1, '2026-02-20 12:24:50', 'Contract', 26000),
(20, 'Machine Learning Intern', 'OpenAI', 'Pune, India', '₹35,000 / month', 'Assist in building and optimizing ML models.', 85, 2, '2026-02-20 12:29:49', 'Full-time', 35000),
(21, 'React Developer Intern', 'Flipkart', 'Bangalore, India', '₹30,000 / month', 'Build scalable frontend apps.', 75, 1, '2026-02-20 13:44:07', 'Full-time', 30000),
(22, 'Data Science Intern', 'Zomato', 'Gurgaon, India', '₹28,000 / month', 'Analyze user data and trends.', 70, 2, '2026-02-20 13:44:07', 'Full-time', 28000),
(23, 'Backend Intern', 'Paytm', 'Noida, India', '₹32,000 / month', 'Work on APIs and databases.', 80, 1, '2026-02-20 13:44:07', 'Full-time', 32000),
(24, 'ML Intern', 'TCS', 'Mumbai, India', '₹24,000 / month', 'Assist in ML model training.', 65, 2, '2026-02-20 13:44:07', 'Part-time', 24000);

-- --------------------------------------------------------

--
-- Table structure for table `internship_skills`
--

CREATE TABLE `internship_skills` (
  `id` int(11) NOT NULL,
  `internship_id` int(11) DEFAULT NULL,
  `skill_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internship_skills`
--

INSERT INTO `internship_skills` (`id`, `internship_id`, `skill_name`) VALUES
(1, 15, 'html'),
(2, 15, 'css'),
(3, 15, 'javascript'),
(4, 15, 'react'),
(5, 15, 'tailwind'),
(6, 15, 'git'),
(7, 15, 'figma'),
(8, 16, 'python'),
(9, 16, 'flask'),
(10, 16, 'mysql'),
(11, 16, 'rest api'),
(12, 16, 'docker'),
(13, 16, 'aws'),
(14, 16, 'redis'),
(15, 17, 'html'),
(16, 17, 'css'),
(17, 17, 'javascript'),
(18, 17, 'python'),
(19, 17, 'flask'),
(20, 17, 'mysql'),
(21, 17, 'react'),
(22, 17, 'node'),
(23, 17, 'git'),
(24, 17, 'aws'),
(25, 18, 'python'),
(26, 18, 'sql'),
(27, 18, 'mysql'),
(28, 18, 'postgresql'),
(29, 18, 'excel'),
(30, 18, 'power bi'),
(31, 18, 'tableau'),
(32, 19, 'java'),
(33, 19, 'c'),
(34, 19, 'mysql'),
(35, 19, 'git'),
(36, 19, 'system design'),
(37, 19, 'oop'),
(38, 19, 'data structures'),
(46, 20, 'python'),
(47, 20, 'machine learning'),
(48, 20, 'tensorflow'),
(49, 20, 'pytorch'),
(50, 20, 'deep learning'),
(51, 20, 'nlp'),
(52, 20, 'aws'),
(53, 21, 'html'),
(54, 21, 'css'),
(55, 21, 'javascript'),
(56, 21, 'react'),
(57, 21, 'redux'),
(58, 21, 'bootstrap'),
(59, 21, 'git'),
(60, 21, 'figma'),
(61, 21, 'rest api'),
(62, 22, 'python'),
(63, 22, 'pandas'),
(64, 22, 'numpy'),
(65, 22, 'matplotlib'),
(66, 22, 'sql'),
(67, 22, 'statistics'),
(68, 22, 'data visualization'),
(69, 22, 'excel'),
(70, 22, 'machine learning'),
(71, 23, 'python'),
(72, 23, 'flask'),
(73, 23, 'rest api'),
(74, 23, 'mysql'),
(75, 23, 'postgresql'),
(76, 23, 'git'),
(77, 23, 'docker'),
(78, 23, 'authentication'),
(79, 23, 'api integration'),
(80, 24, 'python'),
(81, 24, 'machine learning'),
(82, 24, 'scikit-learn'),
(83, 24, 'pandas'),
(84, 24, 'numpy'),
(85, 24, 'tensorflow'),
(86, 24, 'data preprocessing'),
(87, 24, 'model evaluation'),
(88, 24, 'deep learning');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `chapter_no` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT 0,
  `order_no` int(11) DEFAULT 1,
  `is_preview` tinyint(1) DEFAULT 0,
  `content_type` enum('video','note','quiz') DEFAULT 'video',
  `content_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `title`, `chapter_no`, `module_id`, `duration_minutes`, `order_no`, `is_preview`, `content_type`, `content_url`) VALUES
(1, 'Arrays', 1, 1, 0, 1, 0, 'video', 'videos/data_structures/ch1_intro.mp4'),
(2, 'Linked List', 2, 1, 0, 1, 0, 'video', NULL),
(3, 'Stack', 3, 1, 0, 1, 0, 'video', NULL),
(4, 'Queue', 4, 1, 0, 1, 0, 'video', NULL),
(5, 'Trees', 5, 1, 0, 1, 0, 'video', NULL),
(6, 'Binary Trees', NULL, 2, 22, 1, 0, 'video', NULL),
(7, 'Binary Search Tree', NULL, 2, 20, 2, 0, 'video', NULL),
(8, 'DFS & BFS', NULL, 2, 24, 3, 0, 'video', NULL),
(9, 'Graph Representation', NULL, 2, 19, 4, 0, 'video', NULL),
(10, 'Heaps', NULL, 3, 20, 1, 0, 'video', NULL),
(11, 'Priority Queue', NULL, 3, 18, 2, 0, 'video', NULL),
(12, 'Hash Tables', NULL, 3, 23, 3, 0, 'video', NULL),
(13, 'Arrays', 1, 1, 0, 1, 0, 'note', 'notes/data_structures/ch1_arrays.pdf'),
(20, 'What is Machine Learning?', 1, 7, 15, 1, 1, 'video', 'videos/ml/intro.mp4'),
(21, 'ML Terminology Notes', 1, 7, 10, 2, 0, 'note', 'notes/ml/terms.pdf'),
(22, 'Linear Regression', 1, 8, 25, 1, 0, 'video', 'videos/ML/index.mp4'),
(23, 'Regression Quiz', 1, 8, 10, 2, 0, 'video', '\"C:\\Users\\thake\\Downloads\\index (5).mp4\"'),
(24, 'Module 1.1 - Course Introduction', 1, 10, 10, 1, 1, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 1.1.mp4'),
(25, 'Module 1.2 - HTML Basics', 1, 10, 15, 2, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 1.2.mp4'),
(26, 'Module 1.3 - HTML Elements', 1, 10, 18, 3, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 1.3.mp4'),
(27, 'Module 1.4 - HTML Forms', 1, 10, 20, 4, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 1.4.mp4'),
(28, 'Introduction to CSS', 1, 11, 0, 1, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 2.1.mp4'),
(29, 'CSS Selectors & Properties', 2, 11, 0, 2, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 2.2.mp4'),
(30, 'CSS Box Model', 3, 11, 0, 3, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 2.3.mp4'),
(31, 'Flexbox & Layout', 4, 11, 0, 4, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 2.4.mp4'),
(32, 'Responsive Design & Media Queries', 5, 11, 0, 5, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 2.5.mp4'),
(45, 'JavaScript Introduction', 1, 12, 10, 1, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.1.mp4'),
(46, 'Variables & Data Types', 2, 12, 12, 2, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.2.mp4'),
(47, 'Operators & Conditions', 3, 12, 14, 3, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.3.mp4'),
(48, 'Loops in JavaScript', 4, 12, 15, 4, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.4.mp4'),
(49, 'Functions in JavaScript', 5, 12, 18, 5, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.5.mp4'),
(50, 'DOM Manipulation', 6, 12, 20, 6, 0, 'video', 'videos/Introduction_to_HTML_CSS_JS/Module 3.6.mp4'),
(51, 'Module 1.1 - Introduction to Java Programming', 1, 13, 5, 1, 1, 'video', 'videos/Introduction_to_Java/Module 1.1.mp4'),
(52, 'Module 1.2 - Overview of Core Java Platform', 1, 13, 6, 2, 0, 'video', 'videos/Introduction_to_Java/Module 1.2.mp4'),
(53, 'Module 1.3 - Understanding JDK', 1, 13, 5, 3, 0, 'video', 'videos/Introduction_to_Java/Module 1.3.mp4'),
(54, 'Module 1.4 - Features and Benefits of Java', 1, 13, 6, 4, 0, 'video', 'videos/Introduction_to_Java/Module 1.4.mp4'),
(55, 'Module 2.1 - Write Once Run Anywhere', 1, 14, 6, 1, 0, 'video', 'videos/Introduction_to_Java/Module 2.1.mp4'),
(56, 'Module 2.2 - Java Syntax and Structure', 1, 14, 5, 2, 0, 'video', 'videos/Introduction_to_Java/Module 2.2.mp4'),
(57, 'Module 2.3 - Packages and Libraries', 1, 14, 6, 3, 0, 'video', 'videos/Introduction_to_Java/Module 2.3.mp4'),
(58, 'Module 2.4 - Connectivity and Performance', 1, 14, 6, 4, 0, 'video', 'videos/Introduction_to_Java/Module 2.4.mp4'),
(59, 'Module 3.1 - Java Editions SE EE ME', 1, 15, 5, 1, 0, 'video', 'videos/Introduction_to_Java/Module 3.1.mp4'),
(60, 'Module 3.2 - Java Operators', 1, 15, 5, 2, 0, 'video', 'videos/Introduction_to_Java/Module 3.2.mp4'),
(61, 'Module 3.3 - Control Flow Statements', 1, 15, 6, 3, 0, 'video', 'videos/Introduction_to_Java/Module 3.3.mp4'),
(62, 'Module 3.4 - Loops in Java', 1, 15, 5, 4, 0, 'video', 'videos/Introduction_to_Java/Module 3.4.mp4');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_progress`
--

CREATE TABLE `lesson_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lesson_progress`
--

INSERT INTO `lesson_progress` (`id`, `user_id`, `lesson_id`, `completed`, `completed_at`) VALUES
(1, 10, 1, 1, NULL),
(2, 10, 2, 1, NULL),
(3, 10, 3, 1, NULL),
(4, 10, 6, 1, NULL),
(5, 10, 7, 1, NULL),
(6, 10, 4, 1, NULL),
(7, 10, 5, 1, NULL),
(8, 10, 8, 1, NULL),
(10, 10, 9, 1, NULL),
(11, 10, 13, 1, NULL),
(12, 10, 10, 1, NULL),
(13, 8, 22, 1, NULL),
(14, 8, 24, 1, NULL),
(15, 8, 25, 1, NULL),
(16, 8, 26, 1, NULL),
(17, 8, 28, 1, NULL),
(18, 8, 29, 1, NULL),
(19, 8, 30, 1, NULL),
(20, 8, 31, 1, NULL),
(21, 8, 32, 1, NULL),
(22, 8, 45, 1, NULL),
(23, 8, 46, 1, NULL),
(24, 8, 47, 1, NULL),
(25, 8, 48, 1, NULL),
(26, 8, 49, 1, NULL),
(27, 8, 50, 1, NULL),
(28, 8, 27, 1, NULL),
(29, 10, 24, 1, NULL),
(30, 10, 25, 1, NULL),
(31, 10, 26, 1, NULL),
(32, 10, 27, 1, NULL),
(33, 10, 28, 1, NULL),
(34, 10, 29, 1, NULL),
(35, 10, 30, 1, NULL),
(36, 10, 31, 1, NULL),
(37, 10, 32, 1, NULL),
(38, 10, 47, 1, NULL),
(39, 10, 45, 1, NULL),
(40, 10, 46, 1, NULL),
(41, 10, 49, 1, NULL),
(42, 10, 48, 1, NULL),
(43, 10, 50, 1, NULL),
(44, 8, 51, 1, NULL),
(45, 10, 51, 1, NULL),
(46, 10, 52, 1, NULL),
(47, 10, 55, 1, NULL),
(48, 10, 56, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `difficulty` enum('beginner','intermediate','advanced') DEFAULT 'beginner',
  `order_no` int(11) DEFAULT 1,
  `is_locked` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `course_id`, `title`, `description`, `difficulty`, `order_no`, `is_locked`, `created_at`) VALUES
(1, 2, 'Module 1: Data Structures', NULL, 'beginner', 1, 0, '2026-02-13 08:09:18'),
(2, 2, 'Module 2: Trees & Graphs', 'Advanced tree structures and graph traversal', 'intermediate', 2, 0, '2026-02-13 08:28:00'),
(3, 2, 'Module 3: Advanced Structures', 'Heaps, Hashing and more', 'advanced', 3, 0, '2026-02-13 08:28:00'),
(7, 5, 'Module 1: Introduction to ML', 'Basics of ML', '', 1, 0, '2026-02-13 18:01:48'),
(8, 5, 'Module 2: Supervised Learning', 'Regression & Classification', '', 2, 1, '2026-02-13 18:01:48'),
(9, 5, 'Module 3: Unsupervised Learning', 'Clustering', '', 3, 1, '2026-02-13 18:01:48'),
(10, 6, 'Module 1: HTML Fundamentals', 'Learn HTML basics and structure', 'beginner', 1, 0, '2026-02-13 19:43:22'),
(11, 6, 'Module 2: CSS Styling', 'Learn CSS and styling techniques', 'beginner', 2, 0, '2026-02-13 19:43:22'),
(12, 6, 'Module 3: JavaScript Basics', 'Learn JavaScript fundamentals', 'beginner', 3, 0, '2026-02-13 19:43:22'),
(13, 7, 'Welcome to Java', NULL, 'beginner', 1, 0, '2026-02-20 21:20:05'),
(14, 7, 'Benefits of Java', NULL, 'beginner', 2, 0, '2026-02-20 21:20:05'),
(15, 7, 'Java Fundamentals', NULL, 'beginner', 3, 0, '2026-02-20 21:20:05');

-- --------------------------------------------------------

--
-- Table structure for table `module_quizzes`
--

CREATE TABLE `module_quizzes` (
  `id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `total_marks` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_limit` int(11) DEFAULT 600,
  `points` int(11) DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module_quizzes`
--

INSERT INTO `module_quizzes` (`id`, `module_id`, `title`, `total_marks`, `created_at`, `time_limit`, `points`) VALUES
(1, 10, 'HTML Module Quiz', 10, '2026-02-14 04:51:16', 600, 20),
(2, 13, 'Welcome to Java Quiz', 5, '2026-02-20 21:22:49', 600, 10),
(3, 14, 'Benefits of Java Quiz', 5, '2026-02-20 21:22:49', 600, 10),
(4, 15, 'Java Fundamentals Quiz', 5, '2026-02-20 21:22:49', 600, 10);

-- --------------------------------------------------------

--
-- Table structure for table `module_quiz_questions`
--

CREATE TABLE `module_quiz_questions` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `option_a` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `correct_option` char(1) DEFAULT NULL,
  `marks` int(11) DEFAULT 1,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module_quiz_questions`
--

INSERT INTO `module_quiz_questions` (`id`, `quiz_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_option`, `marks`, `explanation`) VALUES
(21, 1, 'What does HTML stand for?', 'Hyper Text Markup Language', 'High Text Machine Language', 'Hyperlinks and Text Markup Language', 'Home Tool Markup Language', 'A', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(22, 1, 'Which HTML tag is used to create a hyperlink?', '<link>', '<a>', '<href>', '<hyper>', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(23, 1, 'Which tag is used to insert an image in HTML?', '<img>', '<image>', '<src>', '<picture>', 'A', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(24, 1, 'Which attribute is used to provide alternative text for an image?', 'title', 'alt', 'src', 'href', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(25, 1, 'Which tag is used to create a numbered list?', '<ul>', '<ol>', '<li>', '<list>', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(26, 1, 'Which tag is used to define a table row?', '<td>', '<th>', '<tr>', '<row>', 'C', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(27, 1, 'Which HTML element is used for the largest heading?', '<h6>', '<heading>', '<h1>', '<head>', 'C', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(28, 1, 'Which tag is used to create a line break?', '<br>', '<break>', '<lb>', '<newline>', 'A', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(29, 1, 'Which input type is used for passwords?', 'type=\"text\"', 'type=\"password\"', 'type=\"hidden\"', 'type=\"secure\"', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(30, 1, 'Which HTML tag is used to define an unordered list?', '<ul>', '<ol>', '<li>', '<list>', 'A', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(32, 1, 'Which CSS property changes text color?', 'font-style', 'color', 'text-decoration', 'background', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(33, 1, 'Which symbol is used for ID selector in CSS?', '.', '#', '*', '@', 'B', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(34, 1, 'Which JavaScript keyword declares a variable?', 'var', 'int', 'string', 'define', 'A', 1, 'HTML stands for Hyper Text Markup Language. It is used to structure web pages.'),
(35, 2, 'Who developed Java?', 'Microsoft', 'Sun Microsystems', 'Google', 'IBM', 'B', 1, 'Java was developed by Sun Microsystems in 1995.'),
(36, 2, 'Java is a ___ language.', 'Procedural', 'Object-Oriented', 'Markup', 'Assembly', 'B', 1, 'Java follows Object-Oriented Programming principles.'),
(37, 2, 'Which file extension is used for Java source files?', '.class', '.js', '.java', '.py', 'C', 1, '.java is used for source code files.'),
(38, 2, 'Java programs run on which component?', 'Compiler', 'JVM', 'Browser', 'Database', 'B', 1, 'Java programs run on the Java Virtual Machine (JVM).'),
(39, 2, 'JDK stands for?', 'Java Development Kit', 'Java Deployment Kit', 'Java Debug Kit', 'Java Design Kit', 'A', 1, 'JDK stands for Java Development Kit.'),
(40, 3, 'What does WORA stand for?', 'Write Once Run Anywhere', 'Write Only Run Always', 'Work On Remote Access', 'None of these', 'A', 1, 'WORA means Write Once Run Anywhere.'),
(41, 3, 'Java is platform independent because of?', 'JVM', 'HTML', 'Database', 'Server', 'A', 1, 'JVM makes Java platform independent.'),
(42, 3, 'Which package is automatically imported in Java?', 'java.io', 'java.util', 'java.lang', 'java.sql', 'C', 1, 'java.lang is automatically imported.'),
(43, 3, 'Java improves performance using?', 'JIT Compiler', 'HTML', 'CSS', 'XML', 'A', 1, 'JIT improves Java performance.'),
(44, 3, 'Java supports networking through?', 'Sockets', 'Tables', 'Forms', 'Div', 'A', 1, 'Java provides networking using sockets.'),
(46, 4, 'Which statement is used for decision making?', 'loop', 'if', 'print', 'scan', 'B', 1, 'if statement is used for decision making.'),
(47, 4, 'Which loop runs at least once?', 'for', 'while', 'do-while', 'foreach', 'C', 1, 'do-while executes at least once.'),
(48, 4, 'Which operator checks equality?', '=', '==', '!=', '<>', 'B', 1, '== checks equality.'),
(49, 4, 'Switch statement is used for?', 'Looping', 'Multiple conditions', 'Printing', 'Sorting', 'B', 1, 'Switch handles multiple conditions.');

-- --------------------------------------------------------

--
-- Table structure for table `module_quiz_results`
--

CREATE TABLE `module_quiz_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `passed` tinyint(1) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module_quiz_results`
--

INSERT INTO `module_quiz_results` (`id`, `user_id`, `quiz_id`, `score`, `total`, `passed`, `submitted_at`) VALUES
(1, 10, 1, 13, 14, 1, '2026-02-15 09:28:06'),
(11, 8, 1, 12, 14, 1, '2026-02-18 15:39:27'),
(14, 8, 2, 0, 5, 0, '2026-02-20 21:26:24');

-- --------------------------------------------------------

--
-- Table structure for table `resumes`
--

CREATE TABLE `resumes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `ats_score` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resumes`
--

INSERT INTO `resumes` (`id`, `user_id`, `role_id`, `file_path`, `ats_score`, `uploaded_at`) VALUES
(1, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 78, '2026-02-17 08:43:04'),
(2, 10, 1, 'static/resumes\\Design and Implementation of a Transparent Skill-Validated Internship Matching Platform_ A Rule-Based Approach to Connecting Education with Employment.pdf', 47, '2026-02-17 08:43:27'),
(3, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 0, '2026-02-17 13:23:11'),
(4, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 0, '2026-02-17 13:25:24'),
(5, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 0, '2026-02-17 13:27:07'),
(6, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-17 13:38:43'),
(7, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 65, '2026-02-17 13:54:30'),
(8, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 70, '2026-02-17 13:58:42'),
(9, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 68, '2026-02-17 14:05:08'),
(10, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 65, '2026-02-17 14:09:56'),
(11, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 70, '2026-02-17 19:20:14'),
(12, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-17 19:28:26'),
(13, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 01:38:33'),
(14, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 75, '2026-02-20 01:55:31'),
(15, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 46, '2026-02-20 05:22:58'),
(16, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 0, '2026-02-20 08:01:54'),
(17, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 86, '2026-02-20 08:05:40'),
(18, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 09:10:50'),
(19, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 65, '2026-02-20 09:29:49'),
(20, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 09:31:03'),
(21, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-20 09:36:40'),
(22, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 45, '2026-02-20 09:36:57'),
(23, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 35, '2026-02-20 09:37:45'),
(24, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 62, '2026-02-20 09:38:02'),
(25, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 09:51:41'),
(26, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 62, '2026-02-20 09:53:00'),
(27, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 65, '2026-02-20 09:53:17'),
(28, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-20 09:54:32'),
(29, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 58, '2026-02-20 09:55:07'),
(30, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 42, '2026-02-20 09:55:25'),
(31, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 62, '2026-02-20 09:59:42'),
(32, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 35, '2026-02-20 10:00:38'),
(33, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 48, '2026-02-20 10:17:36'),
(34, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 68, '2026-02-20 10:18:03'),
(35, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 48, '2026-02-20 10:32:15'),
(36, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 58, '2026-02-20 10:50:19'),
(37, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-20 10:51:25'),
(38, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 52, '2026-02-20 10:52:27'),
(39, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 67, '2026-02-20 11:28:51'),
(40, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 11:29:36'),
(41, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 11:34:07'),
(42, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 60, '2026-02-20 11:34:20'),
(43, 10, 1, 'static/resumes\\YashKshatriyaResume.pdf', 54, '2026-02-20 11:35:18'),
(44, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 35, '2026-02-20 12:43:47'),
(45, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 40, '2026-02-20 12:44:00'),
(46, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 35, '2026-02-20 13:54:46'),
(47, 8, 15, 'static/resumes\\YashKshatriyaResume.pdf', 45, '2026-02-20 17:37:31'),
(48, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 45, '2026-02-21 03:41:12'),
(49, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-21 05:03:58'),
(50, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 50, '2026-02-21 05:37:24'),
(51, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 45, '2026-02-21 05:38:15'),
(52, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 55, '2026-02-21 05:38:25'),
(53, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 40, '2026-02-21 05:38:37'),
(54, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 45, '2026-02-21 05:38:50'),
(55, 10, 15, 'static/resumes\\YashKshatriyaResume.pdf', 35, '2026-02-21 06:07:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `access_type` varchar(50) NOT NULL DEFAULT 'student',
  `points` int(11) DEFAULT 0,
  `streak` int(11) DEFAULT 0,
  `last_activity` date DEFAULT NULL,
  `level` varchar(50) DEFAULT 'Novice'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `access_type`, `points`, `streak`, `last_activity`, `level`) VALUES
(1, '24002171210189@mail.ljku.edu.in', 'thakershivang21@gmail.com', 'scrypt:32768:8:1$ol5nPo8rCkF3fzpK$3b8278b9d2843c127b499ef196d50cbe8756c3352f6992ee3b39db7eb7aef1984c6ae986fd1fea32051b2a04157f540f31348e6c5e76402ff8ff999e8955adb2', 'student', 0, 0, NULL, 'Novice'),
(3, '24002171210152@mail.ljku.edu.in', 'thakershivang055@gmail.com', 'scrypt:32768:8:1$IZbHNxqjFlbuGzzn$6d59b98ae007757f248d78611076b882ea1820146829e67f67f6ed0131bbe3cd9e2a67794055a9aa31d5b2fac5b1781deb244b234b0bc483a9f77349b8ec2f85', 'student', 0, 0, NULL, 'Novice'),
(7, 'shivang', 'thakershivang@gmail.com', 'scrypt:32768:8:1$tVOt81qBrps3noVf$a83a895635eaa040e5aaae627c8ad3b43ddc73d6c02b66e996523b683fedffac9f560fc8af98ba11d5f7646f4926cf052a4179316b177ebac184e5e08a286b28', 'student', 0, 0, NULL, 'Novice'),
(8, 'shiv@1234', 'thakershivang1@gmail.com', 'scrypt:32768:8:1$i3AkqsKE3bOkhMP0$ad198c6ab0a360eb06e67fb0cdd2c649be8344479088c029ed79effbd3410e7d2821818afe16fbf0a503455edbffde8627afb2dc96db5f419ea8dfb662972282', 'student', 477, 4, NULL, 'Novice'),
(9, 'Yuvrajsinh', 'raolyuvraj@gmail.com', 'scrypt:32768:8:1$KGHG531O3F438Noj$499149ab9cf8dd8fa17902b4508dc41833842ecb2bb9b181f3f5430f4abc075a970707857c3797f620ea21a119bd551f42b72d84a95f1e06eb6c6d60806957da', 'student', 500, 5, NULL, 'Novice'),
(10, 'yash', 'kshatriyayash19@gmail.com', 'scrypt:32768:8:1$HkVvgCGgq2L11gzg$8fae24ecd2a085ddb8d2e9dd154ac6bcb878410aaecfc942a351bb6e1d98aa2584ca3c4f09abedd37e2a432f8fdde0cac2f46d19a0a7c58afbbd6fd8a71a392a', 'student', 1018, 8, NULL, 'Novice'),
(12, 'yash', '1@gmail.com', 'scrypt:32768:8:1$jaQg6qz0h1aZRQae$83c9d547bfcb159eac65e6c11781f783159cad309856e124eb33004fc032491c2c43cddd0769e4947fcb1fe6635d67c0af397e04aba79733088541c72cce4f01', 'student', 0, 0, NULL, 'Novice'),
(13, 'Yash', 'kshatr@gmail.com', 'scrypt:32768:8:1$rA35O6SqunBARBw9$0beeae7b89cf139db50f3fee73c2652939c18c654a78314e36dda2ce13f2d3a824397722b6ab5c135b0aafb0a14425863a91ab5f559b3417481404dcc02b58cb', 'student', 0, 0, NULL, 'Novice'),
(14, 'Diyald-2501', 'laddiya2007@gmail.com', 'scrypt:32768:8:1$wmF2aP3hjNfZY31f$62ddee5a1237c00b12f6aee189ccd1054838a23bb17659d6e0f1c4527b0c3d9fbe2a92410f001d6e503633bb9b2f444e42603f86955b2ed0758da20a2cac36c5', 'student', 400, 2, NULL, 'Novice'),
(16, 'admin', 'admin@gmail.com', 'pbkdf2:sha256:600000$SFMt00y8HmRENm7D$85064272e03052f88389e02d94165d310e718a503ec2a12fcba0a5b767e4685c', 'admin', 0, 0, NULL, 'Novice'),
(17, 'abc', 'abc@gmail.com', 'pbkdf2:sha256:600000$qINyYRE5XbIr62EJ$764f99e8fdabbb8721b367c75096231c613824d0eb9f6803588c7c1c064831de', 'student', 0, 0, NULL, 'Novice');

-- --------------------------------------------------------

--
-- Table structure for table `user_activity`
--

CREATE TABLE `user_activity` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `type` enum('notes','video','quiz') DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_activity`
--

INSERT INTO `user_activity` (`id`, `user_email`, `chapter_id`, `type`, `completed`) VALUES
(1, 'thakershivang1@gmail.com', 1, 'notes', 1),
(2, 'thakershivang1@gmail.com', 1, 'video', 1),
(3, 'kshatriyayash19@gmail.com', 10, 'quiz', 1),
(6, 'kshatriyayash19@gmail.com', 10, 'quiz', 0),
(7, 'kshatriyayash19@gmail.com', 10, 'quiz', 0),
(8, 'kshatriyayash19@gmail.com', 10, 'quiz', 0),
(9, 'thakershivang1@gmail.com', 10, 'quiz', 0),
(10, 'thakershivang1@gmail.com', 10, 'quiz', 0),
(11, 'thakershivang1@gmail.com', 10, 'video', 1),
(12, 'thakershivang1@gmail.com', 10, 'video', 1),
(13, 'thakershivang1@gmail.com', 10, 'video', 1),
(14, 'thakershivang1@gmail.com', 11, 'video', 1),
(15, 'thakershivang1@gmail.com', 11, 'video', 1),
(16, 'thakershivang1@gmail.com', 11, 'video', 1),
(17, 'thakershivang1@gmail.com', 11, 'video', 1),
(18, 'thakershivang1@gmail.com', 11, 'video', 1),
(19, 'thakershivang1@gmail.com', 12, 'video', 1),
(20, 'thakershivang1@gmail.com', 12, 'video', 1),
(21, 'thakershivang1@gmail.com', 12, 'video', 1),
(22, 'thakershivang1@gmail.com', 12, 'video', 1),
(23, 'thakershivang1@gmail.com', 12, 'video', 1),
(24, 'thakershivang1@gmail.com', 12, 'video', 1),
(25, 'thakershivang1@gmail.com', 10, 'video', 1),
(26, 'thakershivang1@gmail.com', 10, 'quiz', 1),
(27, 'kshatriyayash19@gmail.com', 10, 'video', 1),
(28, 'kshatriyayash19@gmail.com', 10, 'video', 1),
(29, 'kshatriyayash19@gmail.com', 10, 'video', 1),
(30, 'kshatriyayash19@gmail.com', 10, 'video', 1),
(31, 'kshatriyayash19@gmail.com', 11, 'video', 1),
(32, 'kshatriyayash19@gmail.com', 11, 'video', 1),
(33, 'kshatriyayash19@gmail.com', 11, 'video', 1),
(34, 'kshatriyayash19@gmail.com', 11, 'video', 1),
(35, 'kshatriyayash19@gmail.com', 11, 'video', 1),
(36, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(37, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(38, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(39, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(40, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(41, 'kshatriyayash19@gmail.com', 12, 'video', 1),
(42, 'thakershivang1@gmail.com', 13, 'quiz', 0),
(43, 'thakershivang1@gmail.com', 13, 'video', 1),
(44, 'kshatriyayash19@gmail.com', 10, 'quiz', 1),
(45, 'kshatriyayash19@gmail.com', 13, 'video', 1),
(46, 'kshatriyayash19@gmail.com', 13, 'video', 1),
(47, 'kshatriyayash19@gmail.com', 14, 'video', 1),
(48, 'kshatriyayash19@gmail.com', 14, 'video', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_skills`
--

CREATE TABLE `user_skills` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `skill_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_skills`
--

INSERT INTO `user_skills` (`id`, `user_id`, `skill_name`) VALUES
(439, 8, 'bootstrap'),
(436, 8, 'css'),
(433, 8, 'flask'),
(440, 8, 'git'),
(438, 8, 'github'),
(431, 8, 'html'),
(432, 8, 'java'),
(434, 8, 'javascript'),
(437, 8, 'mysql'),
(435, 8, 'python'),
(573, 10, 'bootstrap'),
(580, 10, 'css'),
(572, 10, 'flask'),
(574, 10, 'git'),
(576, 10, 'github'),
(577, 10, 'html'),
(579, 10, 'java'),
(575, 10, 'javascript'),
(571, 10, 'mysql'),
(578, 10, 'python');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatbot_history`
--
ALTER TABLE `chatbot_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_conversation_id` (`conversation_id`),
  ADD KEY `idx_sender_id` (`sender_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_is_read` (`is_read`);

--
-- Indexes for table `chat_notifications`
--
ALTER TABLE `chat_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_conversation_id` (`conversation_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `fk_notification_message` (`message_id`);

--
-- Indexes for table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_participant` (`conversation_id`,`user_id`),
  ADD KEY `idx_conversation_id` (`conversation_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_course_faculty` (`faculty_id`);

--
-- Indexes for table `doubt_conversations`
--
ALTER TABLE `doubt_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_student_id` (`student_id`),
  ADD KEY `idx_faculty_id` (`faculty_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_applications`
--
ALTER TABLE `internship_applications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_roles`
--
ALTER TABLE `internship_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `internship_skills`
--
ALTER TABLE `internship_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_internship_skills_intern` (`internship_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indexes for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`lesson_id`),
  ADD KEY `lesson_id` (`lesson_id`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `module_quizzes`
--
ALTER TABLE `module_quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indexes for table `module_quiz_questions`
--
ALTER TABLE `module_quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `module_quiz_results`
--
ALTER TABLE `module_quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_attempt` (`user_id`,`quiz_id`);

--
-- Indexes for table `resumes`
--
ALTER TABLE `resumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_resumes_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_skills`
--
ALTER TABLE `user_skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_skill` (`user_id`,`skill_name`),
  ADD KEY `idx_user_skills_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatbot_history`
--
ALTER TABLE `chatbot_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chat_notifications`
--
ALTER TABLE `chat_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `doubt_conversations`
--
ALTER TABLE `doubt_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `faculties`
--
ALTER TABLE `faculties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `internship_applications`
--
ALTER TABLE `internship_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `internship_roles`
--
ALTER TABLE `internship_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `internship_skills`
--
ALTER TABLE `internship_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `modules`
--
ALTER TABLE `modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `module_quizzes`
--
ALTER TABLE `module_quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `module_quiz_questions`
--
ALTER TABLE `module_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `module_quiz_results`
--
ALTER TABLE `module_quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `resumes`
--
ALTER TABLE `resumes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `user_skills`
--
ALTER TABLE `user_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=581;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_course_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `enrollments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `enrollments_ibfk_4` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

--
-- Constraints for table `internship_skills`
--
ALTER TABLE `internship_skills`
  ADD CONSTRAINT `fk_internship_skill` FOREIGN KEY (`internship_id`) REFERENCES `internship_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `internship_skills_ibfk_1` FOREIGN KEY (`internship_id`) REFERENCES `internship_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`);

--
-- Constraints for table `lesson_progress`
--
ALTER TABLE `lesson_progress`
  ADD CONSTRAINT `lesson_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lesson_progress_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`);

--
-- Constraints for table `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

--
-- Constraints for table `module_quizzes`
--
ALTER TABLE `module_quizzes`
  ADD CONSTRAINT `module_quizzes_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `module_quiz_questions`
--
ALTER TABLE `module_quiz_questions`
  ADD CONSTRAINT `module_quiz_questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `module_quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resumes`
--
ALTER TABLE `resumes`
  ADD CONSTRAINT `fk_resume_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_skills`
--
ALTER TABLE `user_skills`
  ADD CONSTRAINT `fk_user_skill` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_skills_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
