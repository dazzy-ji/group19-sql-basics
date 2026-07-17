-- =========================================================================
-- INDIVIDUAL TASKS: MEMBER D (COURSES)
-- =========================================================================

-- CREATE TABLE Statement (Tasks 1, 2, 3)
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

-- INSERT Statement (Task 4)
INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id) VALUES
(501, 'Introduction to Linux', 4, 1, 101),
(502, 'Database Management Systems', 3, 2, 102),
(503, 'Introduction to Python', 3, 3, 103),
(504, 'Data Structures and Algorithms', 4, 1, 102),
(505, 'Self Leadership', 2, 4, 104);

-- UPDATE and DELETE Statements (Task 5)
UPDATE Courses SET credits = 4 WHERE course_id = 502;
DELETE FROM Courses WHERE course_id = 505;

-- SELECT Statement (Task 6)
SELECT course_id, course_name, credits FROM Courses WHERE credits >= 3;
