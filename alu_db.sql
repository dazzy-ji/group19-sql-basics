CREATE DATABASE ALU_DATABASE;

CREATE TABLE classroom(
    classroom_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    building VARCHAR(50),
    capacity INT
);
INSERT INTO classroom(classroom_id , room_number ,building ,capacity )
VALUES
(101, '1a ', 'KENYA', 100),
(102, '2b ', 'EGYPT', 55),
(103, '3c', 'RWANDA', 80),
(104, '4d', 'NIGERIA', 105),
(105, '5e', 'TANZANIA', 20);


CREATE Table Students(
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    classroom_id INT,
    Foreign Key (classroom_id) REFERENCES classroom(classroom_id),
    enrollment_date DATE
);

INSERT INTO Students(student_id, name, email, classroom_id, enrollment_date) VALUES
(001, 'Dazzy Indimuli', 'd.indimuli@alustudent.com', 101, '2026-01-07'),
(002, 'David Ngure', 'd.wanjiku@alustudent.com', 101, '2026-01-10'),
(003, 'Isaack Kariuki', 'i.kariuki@alustudent.com', 103, '2026-01-08'),
(004, 'Philip Otieno', 'p.otieno@alustudent.com', 104, '2026-01-09'),
(005, 'Arif Antulay', 'a.antulay@alustudent.com', 102, '2026-01-10'),
(006, 'Eddy Mutoniwase', 'e.mutoniwas@alustudent.com', 105, '2026-01-06');

-- Dazzy Indimuli
UPDATE Students 
SET name = 'David Wanjiku'
WHERE student_id = 002;
-- Dazzy Indimuli
DELETE FROM Students 
WHERE student_id = 006;
-- Dazzy Indimuli
SELECT student_id, student_name, enrollment_date 
FROM Students
WHERE student_id = 001;

CREATE TABLE IF NOT EXISTS Faculty (
	faculty_id INT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	department VARCHAR(100) NOT NULL,
	PRIMARY KEY (faculty_id)
);

INSERT INTO Faculty (faculty_id, first_name, last_name, email, department) VALUES
(1, 'Obechukwu', 'Cynthia', 'c.obechukwu@alueducation.com', 'Foundations'),
(2, 'Charisma', 'Bazing', 'c.bazing@alueducation.com', 'Health'),
(3, 'Matilda', 'Bonaventura', 'm.bonaventura@alueducation.com', 'Finance'),
(4, 'Mbavu', 'Destroyer', 'm.destroyer@alueducation.com', 'Vurugu'),
(5, 'Mosiria', 'Majembe', 'm.majembe@alueducation.com', 'Security');

-- =====================================================================
-- MEMBER C: FACULTY QUERIES
-- WRITTEN BY: [Your First and Last Name]
-- =====================================================================

SELECT faculty_id, first_name, last_name, email, department
FROM Faculty
WHERE department = 'Vurugu';

UPDATE Faculty
SET department = 'Software Engineering'
WHERE faculty_id = 4;

-- Fixed: Added the WHERE clause back so you don't empty the whole table!
DELETE FROM Faculty
WHERE faculty_id = 5;


CREATE TABLE Courses (
    course_id INT,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,
    classroom_id INT,
    PRIMARY KEY (course_id),
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id)
);

INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id) VALUES
(501, 'Introduction to Linux', 4, 1, 101),
(502, 'Database Management Systems', 3, 2, 102),
(503, 'Introduction to Python', 3, 3, 103),
(504, 'Data Structures and Algorithms', 4, 1, 102),
(505, 'Self Leadership', 2, 4, 104);

-- Philip Otieno
UPDATE Courses SET credits = 4 WHERE course_id = 502;
-- Philip Otieno
DELETE FROM Courses WHERE course_id = 505;

-- Philip Otieno
SELECT course_id, course_name, credits FROM Courses WHERE credits >= 3;


--------MEMBER E (EXTRA-CURRICULAR) -> ARIF ANTULAY ---------
CREATE TABLE Extra_Curricular_Activities (
	activity_id INT PRIMARY KEY,
	activity_name VARCHAR(100),
	category VARCHAR(50),
	faculty_advisor_id INT,
	FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
);

INSERT INTO Extra_Curricular_Activities (activity_id, activity_name, category, faculty_advisor_id)
VALUES
(601, 'Debate Club',   'Academic',     1),
(602, 'Football Team', 'Sports',       2),
(603, 'Coding Club',   'Technology',   4),
(604, 'Art Society',   'Creative',     3),
(605, 'Chess Club',    'Recreational', 1);


UPDATE Extra_Curricular_Activities SET category = 'STEM' WHERE activity_id = 603;
DELETE FROM Extra_Curricular_Activities WHERE activity_id = 605;

SELECT activity_id, activity_name, category, faculty_advisor_id FROM Extra_Curricular_Activities WHERE category = 'Academic';

-- ====================================
-- MEMBER E (Eddy): JUNCTION TABLES
-- Student_Courses + Student_Activities
-- ====================================

-- ---------- STUDENT_COURSES ----------
CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- INSERT (5+ rows)
INSERT INTO Student_Courses (student_id, course_id, enrollment_date) VALUES
(1, 501, '2026-01-10'),
(1, 502, '2026-01-10'),
(2, 501, '2026-01-11'),
(3, 503, '2026-01-09'),
(4, 504, '2026-01-12'),
(5, 502, '2026-01-13');

-- UPDATE
UPDATE Student_Courses SET enrollment_date = '2026-01-15' WHERE student_id = 1 AND course_id = 501;

-- DELETE
DELETE FROM Student_Courses WHERE student_id = 5 AND course_id = 502;

-- SELECT with WHERE
SELECT * FROM Student_Courses WHERE course_id = 501;


-- ---------- STUDENT_ACTIVITIES ----------
CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    join_date DATE,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
);

-- INSERT (5+ rows)
INSERT INTO Student_Activities (student_id, activity_id, join_date) VALUES
(1, 601, '2026-01-10'),
(2, 602, '2026-01-11'),
(3, 603, '2026-01-09'),
(4, 604, '2026-01-12'),
(6, 601, '2026-01-14');

-- UPDATE
UPDATE Student_Activities SET join_date = '2026-01-16' WHERE student_id = 6 AND activity_id = 601;

-- DELETE
DELETE FROM Student_Activities WHERE student_id = 4 AND activity_id = 604;

-- SELECT with WHERE
SELECT * FROM Student_Activities WHERE activity_id = 601;
