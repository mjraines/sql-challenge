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