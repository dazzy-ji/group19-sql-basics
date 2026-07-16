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



