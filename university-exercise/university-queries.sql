--ROOM CAPACITY
SELECT *
FROM room
WHERE room.capacity >= 100;



--EARLIEST COURSE
SELECT *
FROM course
ORDER BY course.start_time
LIMIT 1;



--BIF MAJOR
-- wrooooooooooooonnnnnnnnnnggggggggg
SELECT *
FROM course
WHERE course.crn IN(
	SELECT enrolled.course_number
    FROM enrolled
    WHERE enrolled.student_id=(
    	SELECT student.id
        FROM student
        WHERE student.id =(  
        	SELECT majors_in.student_id  -- GET STUDENT ID FROM THE DEPARTMENT ---
            FROM majors_in
            WHERE majors_in.dept_id=(  
            	SELECT department.id   -- GET DEPARTMENT ID --------
                FROM department
                WHERE department.name='BIF'
            )
        )
    )
);
-- COOOOOOOOOOOOOOOOOOOOOOOOOOORRRRRRRRRRRRRRREEEEEEEEEEEEEEEEEEEEECTTTTTTTTTTTTTTTTTTTTTTTTT
-- FIND ALL COURSE TAKEN BY BIF MAJORS
-- major has student id and department id
-- course has course and student id
-- I can join on the student id column

SELECT *
FROM course
WHERE course.crn IN(
	SELECT enrolled.course_number
    FROM enrolled
    WHERE enrolled.student_id IN(
    	SELECT student.id
        FROM student
        WHERE student.id IN(  
        	SELECT majors_in.student_id  -- GET STUDENT ID FROM THE DEPARTMENT ---
            FROM majors_in
            WHERE majors_in.dept_id=(  
            	SELECT department.id   -- GET DEPARTMENT ID --------
                FROM department
                WHERE department.name='BIF'
            )
        )
    )
);



--NOT ENROLLED IN A COURSE
SELECT student.name
FROM student
WHERE student.id IN(
	SELECT enrolled.student_id
    FROM enrolled
    WHERE enrolled.course_number IN(
    	SELECT course.crn
        FROM course
        WHERE course.name='NO COURSE'
    )
);


-- COUNT STUDENTS ENROLLED IS CSC275
SELECT count(student.name)
FROM student
WHERE student.id IN(
	SELECT enrolled.student_id
    FROM enrolled
    WHERE enrolled.course_number IN(
    	SELECT course.crn
        FROM course
        WHERE course.name='CSC275'
    )
);



-- COUNT STUDENTS ENROLLED IN ANY COURSE
SELECT COUNT(student.id)
FROM student
WHERE student.id IN(
	SELECT enrolled.student_id
    FROM enrolled
    WHERE enrolled.course_number IN(
    	SELECT course.crn
        FROM course
        WHERE course.name NOT IN ('NO COURSE')
    )
);



-- NUMBER OF MAJORS EACH STUDENT HAS DECLARED
SELECT majors_in.student_id, COUNT(majors_in.dept_id)
FROM majors_in
WHERE majors_in.dept_id IN(
	SELECT department.id
    FROM department
)
GROUP BY majors_in.student_id;



-- For each department with more than one majoring student.
-- print the department???s name and the number of majoring students
SELECT department.name, COUNT(majors_in.student_id)
FROM department, majors_in
WHERE department.id = majors_in.dept_id
GROUP BY department.id;
