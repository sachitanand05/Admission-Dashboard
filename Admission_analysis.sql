-- Admission Dashboard SQL Analysis
-- Source: BTech_Student_Data.xlsx
-- Note: This script focuses on analytical queries. Personal fields
-- (phone, email, full address, father's name) are intentionally excluded.

-- 1. Create the main table
CREATE TABLE admission_students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(150),
    address VARCHAR(500),
    phone_no VARCHAR(30),
    email VARCHAR(150),
    college_name VARCHAR(200),
    admission_fees_inr DECIMAL(12,2),
    fathers_name VARCHAR(150),
    course_name VARCHAR(150)
);

-- 2. Total number of students
SELECT COUNT(*) AS total_students
FROM admission_students;

-- 3. Total admission fee
SELECT SUM(admission_fees_inr) AS total_admission_fee
FROM admission_students;

-- 4. Average admission fee
SELECT ROUND(AVG(admission_fees_inr), 2) AS average_admission_fee
FROM admission_students;

-- 5. Student count by college
SELECT
    college_name,
    COUNT(*) AS student_count
FROM admission_students
GROUP BY college_name
ORDER BY student_count DESC;

-- 6. Admission fee by college
SELECT
    college_name,
    SUM(admission_fees_inr) AS total_admission_fee
FROM admission_students
GROUP BY college_name
ORDER BY total_admission_fee DESC;

-- 7. Average admission fee by college
SELECT
    college_name,
    ROUND(AVG(admission_fees_inr), 2) AS average_admission_fee
FROM admission_students
GROUP BY college_name
ORDER BY average_admission_fee DESC;

-- 8. Student count by course
SELECT
    course_name,
    COUNT(*) AS student_count
FROM admission_students
GROUP BY course_name
ORDER BY student_count DESC;

-- 9. Admission fee by course
SELECT
    course_name,
    SUM(admission_fees_inr) AS total_admission_fee
FROM admission_students
GROUP BY course_name
ORDER BY total_admission_fee DESC;

-- 10. College + course analysis
SELECT
    college_name,
    course_name,
    COUNT(*) AS student_count,
    SUM(admission_fees_inr) AS total_admission_fee
FROM admission_students
GROUP BY college_name, course_name
ORDER BY total_admission_fee DESC;

-- 11. Highest admission fee
SELECT
    student_id,
    student_name,
    college_name,
    course_name,
    admission_fees_inr
FROM admission_students
ORDER BY admission_fees_inr DESC
LIMIT 10;

-- 12. Students paying above the overall average fee
SELECT
    student_id,
    student_name,
    college_name,
    course_name,
    admission_fees_inr
FROM admission_students
WHERE admission_fees_inr > (
    SELECT AVG(admission_fees_inr)
    FROM admission_students
)
ORDER BY admission_fees_inr DESC;

-- 13. Number of courses offered by each college
SELECT
    college_name,
    COUNT(DISTINCT course_name) AS number_of_courses
FROM admission_students
GROUP BY college_name
ORDER BY number_of_courses DESC;

-- 14. Course-wise average fee
SELECT
    course_name,
    ROUND(AVG(admission_fees_inr), 2) AS average_admission_fee
FROM admission_students
GROUP BY course_name
ORDER BY average_admission_fee DESC;

-- 15. College contribution to total admission fee
SELECT
    college_name,
    SUM(admission_fees_inr) AS college_fee,
    ROUND(
        100.0 * SUM(admission_fees_inr) /
        (SELECT SUM(admission_fees_inr) FROM admission_students),
        2
    ) AS fee_contribution_percentage
FROM admission_students
GROUP BY college_name
ORDER BY fee_contribution_percentage DESC;

-- 16. Course contribution to total student count
SELECT
    course_name,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM admission_students),
        2
    ) AS student_percentage
FROM admission_students
GROUP BY course_name
ORDER BY student_percentage DESC;

-- 17. Simple dashboard summary
SELECT
    COUNT(*) AS total_students,
    SUM(admission_fees_inr) AS total_admission_fee,
    ROUND(AVG(admission_fees_inr), 2) AS average_admission_fee,
    COUNT(DISTINCT college_name) AS total_colleges,
    COUNT(DISTINCT course_name) AS total_courses
FROM admission_students;
