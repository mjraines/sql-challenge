-- drop tables 
drop table Employees;
drop table Departments;
drop table Department_Employees;
drop table Department_Manager;
drop table Salaries;
drop table Titles;

--Data Engineering 
--create Employee table 

CREATE TABLE Employees (
    emp_no INT NOT NULL,
	emp_title_id VARCHAR(50) NOT NULL,
    birth_date date NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    hire_date date NOT NULL,
	PRIMARY KEY (emp_no)
);

--show table, checking with imported data 
SELECT * from Employees;

--Create Salaries Table 
CREATE TABLE Salaries (
    emp_no INT NOT NULL,
	salary INT NOT NULL,    
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

--show table 
SELECT * from Salaries;

--create Titles Table 
CREATE TABLE Titles (
	title_id VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL
);

--show table 
SELECT * from Titles;

--create Departments Table 
CREATE TABLE Departments (
    dept_no VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (dept_no)
);
--show table 
select * from Departments;

--create department employees table 
CREATE TABLE Department_Employees (
    emp_no INT NOT NULL,
	dept_no VARCHAR   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
--show table 
select * from Department_Employees;

--create department manager table 
CREATE TABLE Department_Manager (
    dept_no VARCHAR(50) NOT NULL,
    emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);
--show table 
SELECT * from Department_Manager;

-- Data Analysis 

-- 1. Details of each employee: employee number, last name, first name, sex, and salary.
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex,
Salaries.salary
FROM Employees
INNER JOIN Salaries ON
Employees.emp_no = Salaries.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT emp_no, first_name, last_name, hire_date from Employees
WHERE hire_date >= '1985-12-31'
AND hire_date < '1987-01-01';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT Department_Manager.dept_no, 
	   Departments.dept_name,
	   Department_Manager.emp_no,
	   Employees.last_name,
	   Employees.first_name
FROM Department_Manager
INNER JOIN Departments ON
Department_Manager.dept_no = Departments.dept_no
INNER JOIN Employees ON
Department_Manager.emp_no = Employees.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT Employees.emp_no, 
	   Employees.last_name, 
	   Employees.first_name,
	   Departments.dept_name
FROM Employees
INNER JOIN Department_Manager ON
Employees.emp_no = Department_Manager.emp_no
INNER JOIN Departments ON
Department_Manager.dept_no = Departments.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
JOIN Department_Employees ON
e.emp_no = Department_Employees.emp_no
INNER JOIN Departments AS d ON
Department_Employees.dept_no = d.dept_no
WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
JOIN Department_Employees ON
e.emp_no = Department_Employees.emp_no
INNER JOIN Departments AS d ON
Department_Employees.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR 
dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) FROM Employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

