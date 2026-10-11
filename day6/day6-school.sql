-- Day 6 Assignment: School Database
-- SQLite-compatible SQL

PRAGMA foreign_keys = ON;

-- 1. Create the students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

-- 2. Create the courses table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    course_name TEXT NOT NULL UNIQUE
);

-- 3. Create the enrolments table
-- This table connects students and courses and stores grades.
CREATE TABLE enrolments (
    enrolment_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    grade REAL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id),
    CHECK (grade IS NULL OR (grade >= 0 AND grade <= 100))
);

-- 4. Insert sample students
INSERT INTO students (student_id, student_name, email) VALUES
(1, 'Amina Otieno', 'amina@example.com'),
(2, 'Brian Kamau', 'brian@example.com'),
(3, 'Carol Wanjiku', 'carol@example.com');

-- 5. Insert sample courses
INSERT INTO courses (course_id, course_name) VALUES
(1, 'Database Systems'),
(2, 'Web Development'),
(3, 'Computer Networks');

-- 6. Insert at least five enrolments
-- Carol has no enrolments, so she can be found by the fourth query.
INSERT INTO enrolments (enrolment_id, student_id, course_id, grade) VALUES
(1, 1, 1, 85),
(2, 1, 2, 90),
(3, 2, 1, 78),
(4, 2, 3, 82),
(5, 3, 2, 88);

-- QUERY 1: All courses taken by one student, using the student's name
SELECT s.student_name, c.course_name, e.grade
FROM students AS s
JOIN enrolments AS e ON s.student_id = e.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE s.student_name = 'Amina Otieno';

-- QUERY 2: All students enrolled in one course
SELECT s.student_name, c.course_name, e.grade
FROM students AS s
JOIN enrolments AS e ON s.student_id = e.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

-- QUERY 3: Number of students enrolled in each course
-- LEFT JOIN also includes courses with zero enrolments.
SELECT c.course_name,
       COUNT(e.student_id) AS number_of_students
FROM courses AS c
LEFT JOIN enrolments AS e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_id;

-- QUERY 4: Students who have no enrolments
SELECT s.student_id, s.student_name, s.email
FROM students AS s
LEFT JOIN enrolments AS e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- QUERY 5: Update one enrolment's grade
UPDATE enrolments
SET grade = 92
WHERE enrolment_id = 1;

-- Verify the updated grade
SELECT s.student_name, c.course_name, e.grade
FROM enrolments AS e
JOIN students AS s ON e.student_id = s.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE e.enrolment_id = 1;
