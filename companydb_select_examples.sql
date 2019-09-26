-- 0. Retrieve all rows and all columns of employee table
select *
from employee;

-- 0. Retrieve First name and last name of ALL employees
select fname as "First Name", lname as "Last Name"
from employee;



-- 1. Retrieve details of all male employees who draw a salary which is at least 30000
select *
from employee
where sex = 'M' and salary >= 30000;

-- 2. Retrieve the details of all dependents of essn 333445555
select *
from dependent
where essn = '333445555';

-- 3. Retrieve details of projects that are based out Houston or Stafford
select *
from project
where plocation In ('Houston','Stafford');

-- 4. Retrieve details of projects that are based out Houston or belongs
--    to deptartment 4
select *
from project
where plocation In ('Houston') or dnum=4;

-- 5. Display the name of the department and the year in which the manager
--    was appointed 
select dname, YEAR(mgr_start_date) --would not work if you run it here since we are not using MySql
from department;
----use the queries below
select dname, extract(year from mgr_start_date)
from department;

-- 6. Display the SSN of all employees who live in Houston
--    (Hint: use LIKE() function as in address LIKE '%Houston'

select ssn
from employee
where address like '%Houston%';

-- 6. Display employees whose name begins with J

select fname
from employee
where fname like 'J%';

-- 7. Display details of all (male employee who earn more than 30000) or female employees who earn less than 30000)
select * from employee;

select *
from employee
where (sex = 'M' and salary>30000) or (sex = 'F' and salary<30000);

-- 8. Display the essn of employees who have worked betwen 25 and 50 hours
--      a) Use AND clause
--      b) use BETWEEN clause  as in Hours between 25 and 30

select essn, hours
from works_on
where hours >= 25 and hours <= 30;

select essn, hours
from works_on
where hours between 25 and 30;


-- 9. Display the names of projects that are based out of houston or stafford
--      a) Use OR clause
--      b) Use IN clause as in Plocation in ('Houston', 'Stafford')

select * from dept_locations
where dlocation in ('Houston','Stafford');

select * from dept_locations 
where dlocation='Houston' or dlocation='Stafford';

-- 10. Display the names of the project that are neither based out of houston nor out of stafford
--      a) Use AND/OR clause
--      b) use NOT IN clause as in Plocation NOT IN ('Houston','Stafford')

select *
from project
where plocation not in ('Houston','Stafford');

select * 
from project 
where plocation <> 'Houston' and plocation <> 'Stafford';


-- 11. Display the ssn and fully concatenated name of all employees
-- 	Use CONCAT function as in CONCAT(fname, ' ', minit, ' ', lname)

select ssn,concat(fname,' ',minit,' ',lname)
from employee;

-- 12. Display the employee details who does not have supervisor
-- 	Use IS NULL as in super_ssn IS NULL

select *
from employee
where super_ssn IS null;


-- 13. Display the ssn of employees sorted by their salary in ascending mode
-- 	Use ORDER by SALARY

select ssn, salary, dno
from employee
where dno = 5
order by salary asc;

-- 14. Sort the works_on table based on Pno and Hours

select * from works_on order by pno,hours;


-- 15. Display the average project hours 

select avg(hours) as "Average Hours"--do not use single quotes here
from works_on;

-- 16. Display the number of employees who do not have a manager

select count(*)
from employee
where super_ssn IS NULL;

select count(super_ssn)
from employee;

-- 17. What is the average salary of employees who do not have a manager
select avg(salary)
from employee
where super_ssn is NULL;

-- 18. What is the highest salary of female employees

select max(salary) 
from employee 
where sex = 'F';

-- 19. What is the least salary of male employees
select min(salary)
from employee
where sex='M';

-- 20. Display the number of employees in each department

select dno, count(*) as "Number of employees"
from employee
group by dno;

select dno, count(*) as "Number of employees"
from employee
group by dno
order by dno;

-- 21. Display the average salary of employees (department-wise and gender-wise)
-- 	GROUP BY Dno, Sex

select dno, sex, avg(salary)
from employee
where super_ssn = '333445555'
group by dno, sex;


-- 22. Display the number of male employees in each department

select dno,count(*)
from employee
group by dno;

-- 23. Display the average, minimum, maximum hours spent in each project

select pno, avg(hours), min(hours), max(hours)
from works_on
group by pno;


-- 24. Display the year-wise count of employees based on their year of birth

select extract(year from bdate), count(*)
from employee
group by extract(year from bdate)
order by extract(year from bdate);

-- 25. Dipslay the number of projects each employee is working on
select essn,count(pno)
from works_on
group by essn;

-- 26. Display the Dno of those departments that has at least 3 employees
select dno, count(*)
from employee
group by dno
having count(*) >= 3;

-- 27. Among the people who draw at least 30000 salary, what is the department-wise average?

select dno, avg(salary)
from employee
where salary >= 30000
group by dno;

-- 27b. Instead of dno, display dname
select dname, avg(salary) from employee inner join department on dno=dnumber where salary >= 30000 group by dname order by dname;

-- 28. Display the fname of employees working in the Research department
select fname
from employee
where dno = (select Dnumber from department where dname = 'Research')
order by fname;


-- 29. Display the fname and salary of employees whose salary is more than the average salary of all the employees
select fname, salary
from employee
where salary >= (select avg(salary) from employee);

--INSERT

select * from dependent;
insert into dependent values('333445555','James','M','1989-04-05','Son');

--DELETE

delete from dependent 
where dependent_name = 'Joy';

--UPDATE
update dependent 
set dependent_name = 'George' 
where dependent_name = 'James';