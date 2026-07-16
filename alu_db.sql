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
