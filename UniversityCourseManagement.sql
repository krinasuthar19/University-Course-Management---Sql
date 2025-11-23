CREATE DATABASE universitycoursemanagement;
Use universitycoursemanagement;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(150),
    BirthDate DATE,
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(150),
    DepartmentID INT,
    Credits INT,
    CONSTRAINT fk_courses_dept FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(150),
    DepartmentID INT,
    CONSTRAINT fk_instructors_dept FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    CONSTRAINT fk_enrollments_student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enrollments_course FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES (3, 'Sam', 'Green', 'sam.green@univ.com', '2001-02-02', '2023-01-15');

SELECT * FROM Students;

UPDATE Students SET Email = 'john.doe@updated.com' WHERE StudentID = 1;


INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES (103, 'Algorithms', 1, 4);
SELECT * FROM Courses;
UPDATE Courses SET Credits = 5 WHERE CourseID = 103;

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES (3,'Carol','Ng','carol.ng@univ.com',1);
SELECT * FROM Instructors;
UPDATE Instructors SET Email = 'alice.j@univ.com' WHERE InstructorID = 1;

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (3,1,102,'2023-09-01');
SELECT * FROM Enrollments;
UPDATE Enrollments SET EnrollmentDate = '2023-09-02' WHERE EnrollmentID = 3;

SELECT * FROM Departments;

SELECT StudentID, FirstName, LastName, EnrollmentDate
FROM Students
WHERE EnrollmentDate > '2022-12-31';

SELECT C.CourseID, C.CourseName, C.Credits
FROM Courses C
JOIN Departments D ON C.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Mathematics'
LIMIT 5;

SELECT C.CourseID, C.CourseName, COUNT(E.StudentID) AS StudentCount
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.CourseName
HAVING COUNT(E.StudentID) > 5;


SELECT S.StudentID, S.FirstName, S.LastName
FROM Students S
WHERE S.StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID IN (101, 102)
    GROUP BY StudentID
    HAVING COUNT(DISTINCT CourseID) = 2
);

SELECT DISTINCT S.StudentID, S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.CourseID IN (101, 102);

SELECT ROUND(AVG(Credits),2) AS AvgCredits FROM Courses;


ALTER TABLE Instructors ADD COLUMN Salary DECIMAL(10,2) NULL;
UPDATE Instructors SET Salary = CASE WHEN InstructorID = 1 THEN 80000 WHEN InstructorID = 2 THEN 70000 ELSE 60000 END;
SELECT MAX(I.Salary) AS MaxSalaryCS
FROM Instructors I
JOIN Departments D ON I.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Computer Science';

SELECT D.DepartmentID, D.DepartmentName, COUNT(DISTINCT E.StudentID) AS StudentsInDept
FROM Departments D
LEFT JOIN Courses C ON D.DepartmentID = C.DepartmentID
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY D.DepartmentID, D.DepartmentName;

SELECT S.StudentID, S.FirstName, S.LastName, C.CourseID, C.CourseName, E.EnrollmentDate
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

SELECT S.StudentID, S.FirstName, S.LastName, C.CourseID, C.CourseName, E.EnrollmentDate
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
LEFT JOIN Courses C ON E.CourseID = C.CourseID;

SELECT DISTINCT S.StudentID, S.FirstName, S.LastName
FROM Students S
WHERE S.StudentID IN (
    SELECT E.StudentID
    FROM Enrollments E
    WHERE E.CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);

SELECT StudentID, FirstName, LastName, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;

SELECT InstructorID, CONCAT(FirstName, ' ', LastName) AS FullName, Email
FROM Instructors;


SELECT EnrollmentID, EnrollmentDate, StudentID, CourseID,
       COUNT(*) OVER (ORDER BY EnrollmentDate, EnrollmentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningEnrollmentCount
FROM Enrollments
ORDER BY EnrollmentDate, EnrollmentID;


SELECT StudentID, FirstName, LastName, EnrollmentDate,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, EnrollmentDate, CURDATE()) > 4 THEN 'Senior'
         ELSE 'Junior'
       END AS StudentLevel
FROM Students;