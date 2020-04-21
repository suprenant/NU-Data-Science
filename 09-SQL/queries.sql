--List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary 
from employees
	join salaries on employees.emp_no = salaries.emp_no;

--List employees who were hired in 1986.
select * 
from employees where hire_date >= '1986-01-01 00:00:00' and hire_date < '1987-01-01 00:00:00'
	order by emp_no asc;

--List all employees whose first name is "Hercules" and last names begin with "B."
select * 
from employees where first_name = 'Hercules' and last_name like 'B%'
	order by emp_no asc;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "frequency" 
from employees 
	group by last_name 
	order by count(last_name) desc;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp 
	join employees on dept_emp.emp_no = employees.emp_no
	join departments on dept_emp.dept_no = departments.dept_no
	order by emp_no asc;	

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from departments
	join dept_manager on departments.dept_no = dept_manager.dept_no
	join employees on dept_manager.emp_no = employees.emp_no
	order by emp_no asc;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp 
	join employees on dept_emp.emp_no = employees.emp_no
	join departments on dept_emp.dept_no = departments.dept_no where departments.dept_name = 'Sales'
	order by emp_no asc;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp 
	join employees on dept_emp.emp_no = employees.emp_no
	join departments on dept_emp.dept_no = departments.dept_no
	where departments.dept_name = 'Sales' 
	or departments.dept_name = 'Development'
	order by emp_no asc;