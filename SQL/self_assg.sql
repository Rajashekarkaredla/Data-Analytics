--Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    country VARCHAR(50),
    registered_on DATE
);
INSERT INTO students (student_id, full_name, country, registered_on) VALUES
(101, 'Aditi Mehra', 'India', '2023-06-12'),
(102, 'Tom Richardson', 'USA', '2022-11-04'),
(103, 'Li Wei', 'China', '2024-02-21'),
(104, 'Sara Haddad', 'UAE', '2023-08-09'),
(105, 'Victor Fernández', 'Spain', '2023-04-17');

--Course enrollment table
CREATE TABLE course_enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(100),
    enrollment_date DATE,
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO course_enrollments (enrollment_id, student_id, course_name, enrollment_date, score) VALUES
(201, 101, 'Data Science 101', '2023-06-15', 85),
(202, 102, 'Python for Web Dev', '2022-11-05', 78),
(203, 103, 'Machine Learning', '2024-02-23', 91),
(204, 104, 'Cloud Computing', '2023-08-10', 74),
(205, 101, 'SQL for Analysts', '2023-07-01', 88),
(206, 105, 'Python for Web Dev', '2023-04-20', 80);

--Show all student names and their countries.
SELECT full_name, country
FROM students;

--Find students who registered after January 1, 2023
SELECT full_name
FROM students
WHERE registered_on > '2023-01-01';

--List all distinct course names
SELECT DISTINCT course_name 
FROM course_enrollments ;

--Get names of students from India or China
SELECT full_name 
FROM students
WHERE country = 'India' OR country='China';

--Find students whose names start with the letter 'A'
SELECT full_name 
FROM students
WHERE full_name like 'A%';

--Retrieve all enrollments with scores between 80 and 90.
SELECT * 
FROM course_enrollments 
WHERE score BETWEEN 80 and 90;

--Show enrollments for the course "Python for Web Dev"
SELECT * 
FROM course_enrollments
WHERE course_name='Python for Web Dev';

--Sort students by most recent registration date.
SELECT full_name
FROM students
ORDER BY registered_on DESC;

--Count how many students are there per country.
SELECT country , COUNT(s.country)
FROM students s
GROUP BY country;

--Count the number of courses each student is enrolled in.
SELECT s.full_name, COUNT(e.course_name)
FROM students s 
LEFT JOIN course_enrollments  e ON s.student_id=e.student_id
GROUP BY s.full_name;

--Show average score for each course.
SELECT course_name, ROUND(AVG(score),1)
FROM course_enrollments
GROUP BY course_name;

--Find the highest score in each course.
SELECT course_name,MAX(score)
FROM course_enrollments
GROUP BY course_name;

--List students and their total score across all courses
SELECT s.full_name, SUM(e.score)
FROM students s 
LEFT JOIN course_enrollments e ON s.student_id=e.student_id
GROUP BY s.full_name;

--List student names along with the courses they have enrolled in.
SELECT s.full_name, e.course_name
FROM students s 
LEFT JOIN course_enrollments e ON s.student_id=e.student_id;

--Show student names and their scores for each course
SELECT s.full_name, e.score, e.course_name
FROM students s 
LEFT JOIN course_enrollments e ON s.student_id=e.student_id;

--List all students who have enrolled in more than one course.
SELECT s.full_name, COUNT(DISTINCT e.course_name)
FROM students s
LEFT JOIN course_enrollments e ON s.student_id=e.student_id
GROUP BY s.full_name
HAVING COUNT(e.course_name) >1;

--Get the names of students who took "SQL for Analysts"
SELECT s.full_name
FROM students s 
LEFT JOIN course_enrollments e ON s.student_id=e.student_id
WHERE course_name ='SQL for Analysts';

--Insert a new student from Germany named "Leo Müller"
INSERT INTO students(student_id,full_name,country) VALUES
(106,'Leo Müller','Germany');

--Enroll student 103 in the course "AI Foundations" with a score of 87.
INSERT INTO course_enrollments(enrollment_id,student_id,course_name,score)VALUES
(207,103,'AI Foundations',87);
select * from course_enrollments


--Increase all scores in "SQL for Analysts" by 5 points.
UPDATE  course_enrollments
SET score=score+5
WHERE course_name='SQL for Analysts';

--Delete enrollments with a score less than 75.
DELETE FROM course_enrollments
WHERE score<75

--Update the country of student 105 to "Argentina".
UPDATE students 
SET country ='Argentina'
WHERE student_id=105;

