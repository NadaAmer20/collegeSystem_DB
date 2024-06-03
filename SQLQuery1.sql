
CREATE TABLE department (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100)
);



INSERT INTO department (department_id, department_name)
VALUES
  (1, 'CS'),
  (2, 'IS'),
  (3, 'IT'),
  (4, 'MM');


CREATE TABLE course (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES department(department_id)
); 

INSERT INTO course (course_id, course_name, department_id)
VALUES
  (1, 'Algorithm', 1),
  (5, 'AI', 1),
  (2, 'Database Management', 2),
  (3, 'Network', 3),
  (4, 'Financial Accounting', 4),
  (6, 'Computer vision', 4)
  ---select * from course;


CREATE TABLE student (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  department_id INT,
  grade_id INT,
  last_name VARCHAR(50),
  date_of_birth DATE,
  gender VARCHAR(10),
  address VARCHAR(100),
  email VARCHAR(100),
  phone_number VARCHAR(20),
  FOREIGN KEY (department_id) REFERENCES department(department_id),
);

INSERT INTO student (student_id, first_name,last_name, department_id, grade_id, date_of_birth, gender, address, email, phone_number)
VALUES
  (1, 'Nada', 'amer', 1, 11, '2001-10-10', 'Female', '123 Main St, ASS', 'nada.doe@example.com', '555-123-4567'),
  (2, 'Mina', 'salib', 2,12, '2000-09-21',  'male', '456 Park Ave, Town', 'mina.smith@example.com', '555-987-6543'),
  (3, 'Mina', 'Ashraf', 2,10 , '2001-02-10', 'Male', '789 Oak Rd, Village', 'mina.johnson@example.com', '555-567-8901'),
  (4, 'Salma', 'Ahmed', 3, 15, '2000-11-03', 'Female', '321 Elm Blvd, County', 'salma.williams@example.com', '555-234-5678'),
  (5, 'AYA', 'Omer' , 4, 7, '1998-07-28', 'Male', '555 Pine Dr, State', 'aya.lee@example.com', '555-678-9012');
   
 
CREATE TABLE grades (
  grade_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  grade DECIMAL(5, 2),
  grading_period VARCHAR(20),
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);

INSERT INTO grades (grade_id, student_id, course_id, grade, grading_period)
VALUES
  (1, 1, 1, 87.5, 'Midterm'),
  (2, 1, 2, 92.0, 'Midterm'),
  (3, 1, 3, 78.3, 'Midterm'),
  (4, 2, 1, 94.2, 'Midterm'),
  (5, 2, 2, 88.7, 'Midterm'),
  (6, 2, 3, 81.5, 'Midterm'),
  (7, 3, 1, 89.9, 'Midterm'),
  (8, 3, 2, 95.6, 'Midterm'),
  (9, 3, 3, 90.1, 'Midterm'),
  (10, 4, 1, 76.4, 'Midterm'),
  (11, 4, 2, 82.8, 'Midterm'),
  (12, 4, 3, 77.9, 'Midterm'),
  (13, 5, 1, 93.7, 'Midterm'),
  (14, 5, 2, 90.5, 'Midterm'),
  (15, 5, 3, 88.2, 'Midterm');

UPDATE grades 
SET grade = 97.4
WHERE grade_id = 13;

CREATE TABLE doctor (
  doctor_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone_number VARCHAR(20)
);

-- Insert data into the "doctor" table.
INSERT INTO doctor (doctor_id, first_name, last_name, email, phone_number)
VALUES
  (1, 'ahmed', 'hosny', 'ahmed.doe@example.com', '+1 (123) 456-7890'),
  (2, 'Jane', 'Smith', 'jane.smith@example.com', '+1 (987) 654-3210'),
  (3, 'Mostafa', 'ahmed', 'mosta.johnson@example.com', '+1 (555) 123-4567'),
  (4, 'Sarah', 'eslam', 'sarah.lee@example.com', '+1 (111) 222-3333'),
  (5, 'aya', 'mostafa', 'aya.brown@example.com', '+1 (444) 555-6666');

 --- select * from course;
 -- Update data in the "doctor" table for doctor_id = 1.
UPDATE doctor
SET first_name = 'Mostafa',
last_name='Kamal',
email ='moustafa.lee@example.com',
phone_number= '+1 (444) 555-3333'
WHERE doctor_id = 1;


CREATE TABLE doctor_course (
  doctor_course_id INT PRIMARY KEY,
  doctor_id INT,
  course_id INT,
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- Insert data into the "doctor_course" table.
INSERT INTO doctor_course (doctor_course_id, doctor_id, course_id)
VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 2, 1),
  (4, 2, 3),
  (5, 3, 2)



-- function to calculate the average grade --
CREATE FUNCTION calculate_average_grade (@courseId INT)
  RETURNS DECIMAL
  AS
  BEGIN
    DECLARE @averageGrade DECIMAL(10,2);
	SELECT @averageGrade = 
	( 
      SELECT  AVG(grade)
      FROM grades
      WHERE course_id = @courseId
	)
    RETURN @averageGrade;
  END;
  --SELECT dbo.calculate_average_grade(1) AS AverageGrade;

CREATE VIEW view_students AS
SELECT *
FROM student;

---The procedure retrieves all students and their corresponding department from the students and department tables.---
CREATE PROCEDURE GetStudentsWithDepartment
AS
BEGIN
    SELECT *
    FROM student s
    LEFT JOIN department d ON s.department_id = d.department_id;
END;

---The transaction updates the grade of a specific student for a particular course in the grades table.---

CREATE PROCEDURE UpdateStudentGrade
    @studentId INT,
    @courseId INT,
    @newGrade DECIMAL(5,2)
AS
BEGIN
    BEGIN TRANSACTION;
    UPDATE grades
    SET grade = @newGrade
    WHERE student_id = @studentId AND course_id = @courseId;
    COMMIT TRANSACTION;--executed
END;



CREATE VIEW view_courses_by_department AS
SELECT d.department_name, c.course_name
FROM department d
JOIN course c ON d.department_id = c.department_id;




 
-- Create the function to search for a student by first name and last name.


CREATE FUNCTION find_student (@first_name VARCHAR(50), @last_name VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @result VARCHAR(100)
    
    SELECT @result = CONCAT(first_name, ' ', last_name)
    FROM student
    WHERE first_name = @first_name AND last_name = @last_name
    
    IF @result IS NULL
        SET @result = 'Student not found'
        
    RETURN @result
END

--SELECT dbo.find_student('nada', 'salah')
--SELECT dbo.find_student('nada', 'amer')

