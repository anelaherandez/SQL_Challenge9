-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/G14klY
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


SELECT * FROM "Departments";
SELECT * FROM "Titles";
SELECT * FROM "Employees";
SELECT * FROM "Salaries";
SELECT * FROM "Dept_Emp";
SELECT * FROM "Dept_Manager";

--1) List the employee number, last name, first name, sex, and salary of each employee
SELECT emp_no, last_name, first_name, sex
FROM "Employees";

SELECT salary
FROM "Salaries";

SELECT s.salary, e.last_name, e.first_name, e.sex
FROM "Salaries" as s
INNER JOIN "Employees" as e ON
e.emp_no=s.emp_no;

--2)List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM "Employees"
WHERE date_part ('year', hire_date)= 1986;

--3)List the manager of each department along with their department number,
--department name, employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM "Employees";

SELECT * FROM "Dept_Manager";

SELECT dept_no, dept_name
FROM "Departments";

SELECT m.dept_no, m.emp_no, d.dept_name, e.last_name, e.first_name
FROM "Dept_Manager" as m 
INNER JOIN "Departments" as d ON
m.dept_no= d.dept_no
INNER JOIN "Employees" as e ON
m.emp_no=e.emp_no; 

--4)List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name.
SELECT i.dept_no, i.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Dept_Emp" as i
INNER JOIN "Employees" as e ON
i.emp_no=e.emp_no
INNER JOIN "Departments" as d ON
i.dept_no=d.dept_no; 

--5)List first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM "Employees"
	WHERE first_name='Hercules'
	AND last_name LIKE 'B%';

--6)List each employee in the Sales department, including their employee number,
--last name, and first name
SELECT e.emp_no, e.last_name, e.first_name
FROM "Employees" as e
INNER JOIN "Dept_Emp" as i ON
i.emp_no=e.emp_no
INNER JOIN "Departments" as d ON
d.dept_no=i.dept_no
WHERE d.dept_name='Sales';

--7)List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" as e
INNER JOIN "Dept_Emp" as i ON
i.emp_no=e.emp_no
INNER JOIN "Departments" as d ON
d.dept_no=i.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--8)List the frequency counts, in descending order, 
--of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) as "Last Name Repeat #"
FROM "Employees"
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;




