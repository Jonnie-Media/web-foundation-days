# Day 6 Assignment: School Database Design

## 1. Students Table

The `students` table stores information about students. It contains `student_id`, `student_name`, and `email`. The student ID is the primary key and uniquely identifies each student. The name and email are required, and the email must be unique so that two students cannot register with the same email address.

## 2. Courses Table

The `courses` table stores information about the courses offered by the school. It contains `course_id` and `course_name`. The course ID is the primary key, while the course name is required and unique to prevent duplicate course names.

## 3. Enrolments Table

The `enrolments` table records which students take which courses. It contains `enrolment_id`, `student_id`, `course_id`, and `grade`. The enrolment ID is the primary key. The student ID and course ID are foreign keys referencing the students and courses tables. The grade can be NULL when a student has not yet received a grade, or it can contain a value between 0 and 100.

The combination of `student_id` and `course_id` is UNIQUE. This prevents the same student from enrolling in the same course more than once.

## 4. Relationships Between the Tables

There is a one-to-many relationship between students and enrolments because one student can have multiple enrolment records, while each enrolment belongs to one student. There is also a one-to-many relationship between courses and enrolments because one course can have many enrolment records, while each enrolment refers to one course.

Students and courses have a many-to-many relationship. One student can take several courses, and one course can have several students. The `enrolments` table is necessary as a join table to represent this relationship. It also stores information specific to each enrolment, such as the student's grade in a particular course.

## 5. Recommended Index

I would add an index on `enrolments.course_id` to make it faster to find all students enrolled in a particular course and to calculate the number of students per course. This can improve query performance when the database contains many enrolment records.

Example:

```sql
CREATE INDEX idx_enrolments_course_id
ON enrolments(course_id);
```

The UNIQUE constraint on `(student_id, course_id)` also creates an index in SQLite, helping enforce the rule against duplicate enrolments.

## 6. Choosing SQL or NoSQL

I would choose a relational SQL database such as SQLite for this school system. The data has clear relationships between students, courses, and enrolments, and each table has a well-defined structure. SQL supports primary keys, foreign keys, UNIQUE constraints, and transactions that help maintain data accuracy and integrity. JOIN queries make it easy to retrieve courses for a student, students for a course, and enrolment statistics. A NoSQL database could be useful for a system with highly variable or unstructured data, but a relational database is a better fit for these structured records and relationships.
