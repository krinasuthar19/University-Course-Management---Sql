🎓 University Course Management System

📘 Introduction

The University Course Management System is a fully functional SQL database project designed to demonstrate real-world database management concepts. It includes database creation, table structure design, data insertion, CRUD operations, joins, subqueries, aggregations, and advanced SQL features such as window functions and CASE expressions.

This project simulates a university environment where students enroll in courses, instructors belong to departments, and courses are distributed across academic departments.

🏗️ Database Structure

The system contains five main entities, each representing a functional component of a university.

📁 1. Departments

Stores department details

DepartmentID (Primary Key)

👨‍🎓 2. Students

Contains personal and academic info

StudentID (Primary Key)

📚 3. Courses

Stores course catalog and department mapping

CourseID (Primary Key)

DepartmentID → Foreign Key referencing Departments

👨‍🏫 4. Instructors

Contains faculty information

InstructorID (Primary Key)

DepartmentID → Foreign Key referencing Departments

📝 5. Enrollments

Maps students to courses

EnrollmentID (Primary Key)

StudentID → Foreign Key referencing Students

CourseID → Foreign Key referencing Courses

🛠️ Key Features Demonstrated

This project highlights the following SQL concepts:

✔ Essential Concepts

Database creation

Table creation with keys and constraints

Insert, update, delete operations

Simple and complex SELECT queries

✔ Intermediate Features

INNER, LEFT, RIGHT JOIN

Subqueries (nested, IN, EXISTS)

GROUP BY with HAVING

Sorting & filtering

✔ Advanced SQL

Window functions

CASE expressions

Aggregate analytics

Derived columns

Date and string manipulation

📂 Project Files

Your project includes:

File	Description
university_course_management.sql	Full SQL script (DB creation, tables, inserts, queries)
README.md	Overview and documentation of the project
ER Diagram (optional)	Can be created on request
▶️ How to Run the Project
1. Open MySQL Workbench / phpMyAdmin / XAMPP.
2. Copy all SQL commands from the .sql file
3. Run the script step-by-step or as a whole.

This will:

Create the database

Build all tables

Insert sample data

Execute queries for demonstration

📊 Sample Queries Demonstrated

Some examples included in the project:

List all students

Update instructor salary

Find students enrolled in multiple courses

Count students in each department

Join students with their enrolled courses

Compute running totals using window functions

Use CASE to categorize students as “Senior” or “Junior”
