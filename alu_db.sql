CREATE DATABASE ALU_DATABASE;
USE ALU_DATABASE;
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

#update by David Ngure
UPDATE classroom
SET capacity = 120
WHERE classroom_id = 104;

#select David Ngure
SELECT * FROM classroom;

#Delete  by David ngure
DELETE FROM classroom
WHERE classroom_id = 105;

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
(006, 'Eddy Mutoniwase', 'e.mutoniwas@alustudent.com', 102, '2026-01-06'),
(007, 'Majembe Wanjala', 'm.wanjal@alustudent.com', 102, '2026-02-01');

-- Dazzy Indimuli
UPDATE Students 
SET name = 'David Wanjiku'
WHERE student_id = 002;
-- Dazzy Indimuli
DELETE FROM Students 
WHERE student_id = 007;
-- Dazzy Indimuli
SELECT student_id, name, enrollment_date 
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
-- Isaack Kariuki
SELECT faculty_id, first_name, last_name, email, department
FROM Faculty
WHERE department = 'Vurugu';

-- Isaack Kariuki
UPDATE Faculty
SET department = 'Software Engineering'
WHERE faculty_id = 4;

-- Isaack Kariuki
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

-- Join 1: "Student X is enrolled in Course Y, taught by Faculty Z, in Classroom W."
SELECT CONCAT(
    s.name, ' is enrolled in ', c.course_name,
    ', taught by ', f.first_name, ' ', f.last_name,
    ', in classroom ', cl.room_number, '.'
) AS enrollment_sentence
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c          ON sc.course_id = c.course_id
JOIN Faculty f          ON c.faculty_id = f.faculty_id
JOIN classroom cl       ON c.classroom_id = cl.classroom_id;

-- Join 2: "Student X participates in Activity Y, advised by Faculty Z."
SELECT CONCAT(
    s.name, ' participates in ', a.activity_name,
    ', advised by ', f.first_name, ' ', f.last_name, '.'
) AS activity_sentence
FROM Students s
JOIN Student_Activities sa         ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty f                     ON a.faculty_advisor_id = f.faculty_id;

-- Join 3 (our choice): "Faculty Z teaches Course Y in room W of the B building."
SELECT CONCAT(
    f.first_name, ' ', f.last_name,
    ' teaches ', c.course_name,
    ' in room ', cl.room_number,
    ' of the ', cl.building, ' building.'
) AS teaching_sentence
FROM Faculty f
JOIN Courses c    ON f.faculty_id = c.faculty_id
JOIN classroom cl ON c.classroom_id = cl.classroom_id;

-- Aggregate: how many students are enrolled in each course.
SELECT c.course_name,
       COUNT(sc.student_id) AS total_students
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_students DESC;

/*
NORMALIZATION CHECK (group answer):
We went through each table and we're confident the design is normalized to
3NF. Every table sticks to one job -- students are only in Students, rooms
only in classroom, faculty only in Faculty -- so we never store the same
fact in two places. For example, Courses just keeps the faculty_id and
classroom_id rather than copying the teacher's name or the building. That
way, if a teacher's name changes, we only fix it once.

For the many-to-many parts (a student can take many courses, and a course
can have many students -- same idea with activities), we used the
Student_Courses and Student_Activities junction tables instead of cramming
a bunch of course columns into Students. Each row in those tables is just
one student paired with one course or activity, and since the primary key
is the two IDs together, you can't accidentally add the same pairing twice.

The one thing we noticed is that Students.name puts the full name in a
single column, which technically isn't fully atomic (1NF). Splitting it into
first_name and last_name would be cleaner, but it doesn't affect any of the
relationships, so we left it as is.
*/