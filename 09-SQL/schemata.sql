-- Drop tables (avoid once CSVs imported!)--
drop table departments;
drop table dept_emp;
drop table dept_manager;
drop table employees;
drop table salaries;
drop table titles;

-- Create tables --
create table departments(dept_no varchar(4) not null, dept_name varchar(30) not null);
create table dept_emp(emp_no int not null, dept_no varchar(4) not null, from_date date not null, to_date date not null);	
create table dept_manager(dept_no varchar(4) not null, emp_no int not null, from_date date not null, to_date date not null);
create table employees(emp_no int not null, birth_date date not null, first_name varchar(50) not null, last_name varchar(50) not null, gender varchar(1) not null, hire_date date not null);
create table salaries(emp_no int not null, salary int not null, from_date date not null, to_date date not null);
create table titles(emp_no int not null, title varchar(30) not null, from_date date not null, to_date date not null);