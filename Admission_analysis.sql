-- Admission Dashboard - SQL Analysis

-- 1. Total number of students
SELECT COUNT(*) AS total_students
FROM admission_students;


-- 2. Total admission fees
SELECT SUM(admission_fees_inr) AS total_admission_fees
FROM admission_students;


-- 3. Admission fees by college
SELECT
    college_name,
    SUM(admission_fees_inr) AS total_admission_fees
FROM admission_students
GROUP BY college_name
ORDER BY total_admission_fees DESC;


-- 4. Student distribution by college
SELECT
    college_name,
    COUNT(*) AS total_students
FROM admission_students
GROUP BY college_name
ORDER BY total_students DESC;


-- 5. Student distribution by faculty
SELECT
    faculty,
    COUNT(*) AS total_students
FROM admission_students
GROUP BY faculty
ORDER BY total_students DESC;


-- 6. Student distribution by course
SELECT
    course_name,
    COUNT(*) AS total_students
FROM admission_students
GROUP BY course_name
ORDER BY total_students DESC;


-- 7. Student distribution by location
SELECT
    student_location,
    COUNT(*) AS total_students
FROM admission_students
GROUP BY student_location
ORDER BY total_students DESC;


-- 8. Course filter
SELECT *
FROM admission_students
WHERE course_name = 'Selected Course';


-- 9. Student Location filter
SELECT *
FROM admission_students
WHERE student_location = 'Selected Location';
