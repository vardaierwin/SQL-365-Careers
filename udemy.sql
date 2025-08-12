SELECT 
    dept_no
FROM
    departments;

SELECT 
    *
FROM
    departments;

create database `employees-10`;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';

/* ============================= */

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Kellie' , 'Aruna');

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND first_name IN ('Kellie' , 'Aruna');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');

/* ============================= */

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE 'mark%';

SELECT 
    *
FROM
    employees
WHERE
    YEAR(hire_date) = '2000';

SELECT 
    *
FROM
    employees
WHERE
    LENGTH(emp_no) = 5
        AND emp_no LIKE '1000%';

SELECT 
    *
FROM
    `employees`
WHERE
    first_name LIKE '%jack%';

SELECT 
    *
FROM
    `employees`
WHERE
    first_name NOT LIKE '%jack%';

/* ============================= */

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

SELECT 
    *
FROM
    employees
WHERE
    emp_no BETWEEN 10002 AND 10009;

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN 10003 AND 10008;

/* ============================= */

SELECT 
    d.dept_name
FROM
    departments d
WHERE
    d.dept_no IS NULL;

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND YEAR(hire_date) >= '2000';

SELECT 
    *
FROM
    salaries
WHERE
    salary >= 150000;

/* ============================= */

SELECT DISTINCT
    `hire_date`
FROM
    `employees`;

SELECT 
    from_date, to_date
FROM
    titles;

SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary >= 100000;

SELECT 
    COUNT(*)
FROM
    dept_manager;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/* ============================= */

SELECT 
    salary, COUNT(*) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY 1;

SELECT 
    title, COUNT(emp_no) AS emps_with_same_job_title
FROM
    titles
WHERE
    to_date = '9999-01-01'
GROUP BY title;

SELECT 
    *, AVG(salary) AS avg_salary, COUNT(*)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

with cte as (
select
	first_name,
	count(first_name) as name_count
from
	employees
where
	hire_date > '1999-01-01'
group by
	first_name
having
	name_count < 200
order by
	first_name desc
)
select
	count(*)
from
	cte;

SELECT 
    *, COUNT(from_date) AS count
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING count >= 2
ORDER BY emp_no;

select
	emp_no,
	salary,
	'top' as type
from
	(
	select
		emp_no,
		salary
	from
		salaries
	order by
		salary desc
	limit 10) as top10
union all
select
	emp_no,
	salary,
	'bottom' as type
from
	(
	select
		emp_no,
		salary
	from
		salaries
	order by
		salary asc
	limit 10) as bottom10

select
	*
from
	dept_emp
limit 100;

/* ============================= */

SELECT 
    *
FROM
    titles;

insert
	into
	employees
values
(
    999903,
    '1977-09-14',
    'johnathan',
    'creek',
    'm',
    '1999-01-01'
);

insert
	into
	titles (emp_no,
	title,
	from_date)
values (999903,
'Senior Engineer',
'1997-10-01');

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC;

SELECT 
    *
FROM
    dept_emp;

insert
	into
	dept_emp
values (999903,
'd005',
'1997-10-01',
'9999-01-01');

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC;

SELECT 
    *
FROM
    departments;

insert
	into
	departments
values ('d010',
'Business Analysis');

UPDATE departments 
SET 
    dept_name = 'Data Analyst'
WHERE
    dept_no = 'd010';

SELECT 
    *
FROM
    departments;

DELETE FROM departments 
WHERE
    dept_no = 'd010';

/* ============================= */

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;

SELECT 
    SUM(s.salary)
FROM
    salaries s
WHERE
    s.from_date > '1997-01-01';

SELECT 
    MIN(emp_no), MAX(emp_no)
FROM
    employees;

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments;

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    COALESCE(dept_name,
            'Depertament name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments;

/* ============================= */

CREATE TABLE `departments_dup` (
    `dept_no` CHAR(4),
    `dept_name` VARCHAR(20)
);

insert
	into
	departments_dup
select
	*
from
	departments;

truncate departments_dup;

SELECT 
    *
FROM
    departments_dup;

insert
	into
	departments_dup (dept_name)
values ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

insert
	into
	departments_dup (dept_no)
values ('d010');

insert
	into
	departments_dup (dept_no)
values ('d011');

drop table if exists dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

insert
	into
	dept_manager_dup
select
	*
from
	dept_manager;

insert
	into
	dept_manager_dup (emp_no,
	from_date)
values (999904,
'2017-01-01'),
       (999905,
'2017-01-01'),
       (999906,
'2017-01-01'),
       (999907,
'2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

/* ============================= */

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no
ORDER BY d.emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    last_name = 'Markovitch'
ORDER BY d.dept_no DESC;

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager d
WHERE
    e.emp_no = d.emp_no;

SELECT @@GLOBAL .sql_mode;

set
@@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch';

SELECT 
    *
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    *
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

SELECT 
    *
FROM
    dept_manager
        CROSS JOIN
    departments
WHERE
    departments.dept_no = 'd006';

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    d.from_date,
    d2.dept_name
FROM
    employees e
        JOIN
    titles t ON t.emp_no = e.emp_no
        JOIN
    dept_manager d ON e.emp_no = d.emp_no
        JOIN
    departments d2 ON d2.dept_no = d.dept_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no
;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    de.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
WHERE
    t.title = 'Senior Engineer'
;

SELECT 
    e.gender, COUNT(d.emp_no) AS number_of_managers
FROM
    dept_manager d
        JOIN
    employees e ON e.emp_no = d.emp_no
GROUP BY e.gender
;

SELECT 
    t.title, ROUND(AVG(s.salary), 2) AS avg_salary
FROM
    salaries s
        JOIN
    titles t ON s.emp_no = t.emp_no
GROUP BY t.title
HAVING avg_salary < 75000
ORDER BY avg_salary DESC
;

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC
;

SELECT 
    emp_no,
    first_name,
    last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees
WHERE
    last_name = 'Bamford' 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    dept_no,
    from_date
FROM
    dept_manager
;

/* ============================= */

SELECT 
    *
FROM
    dept_manager d
WHERE
    d.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.hire_date BETWEEN '1990-01-01' AND '1995-01-01')
;

SELECT 
    d.emp_no, d.dept_no, d.from_date
FROM
    dept_manager d
WHERE
    d.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.birth_date >= '1955%')
;

SELECT 
    *
FROM
    employees
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles
        WHERE
            titles.emp_no = employees.emp_no
                AND titles.title = 'Assistant Engineer')
;

SELECT 
    *
FROM
    salaries s
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = s.emp_no
                AND t.title = 'Engineer')
;

select
	sub.emp_no
from
	(
	select
		*
	from
		employees e
	where
		e.emp_no <= 10020) as sub
;

drop table if exists emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

insert
	into
	emp_manager
select
	u.*
from
	(
	select
		a.*
	from
		(
		select
			e.emp_no as employee_ID,
			MIN(de.dept_no) as department_code,
			(
			select
				emp_no
			from
				dept_manager
			where
				emp_no = 110022) as manager_ID
		from
			employees e
		join dept_emp de on
			e.emp_no = de.emp_no
		where
			e.emp_no <= 10020
		group by
			e.emp_no
		order by
			e.emp_no) as a
union
	select
		b.*
	from
		(
		select
			e.emp_no as employee_ID,
			MIN(de.dept_no) as department_code,
			(
			select
				emp_no
			from
				dept_manager
			where
				emp_no = 110039) as manager_ID
		from
			employees e
		join dept_emp de on
			e.emp_no = de.emp_no
		where
			e.emp_no > 10020
		group by
			e.emp_no
		order by
			e.emp_no
		limit 20) as b
union
	select
		c.*
	from
		(
		select
			e.emp_no as employee_ID,
			MIN(de.dept_no) as department_code,
			(
			select
				emp_no
			from
				dept_manager
			where
				emp_no = 110039) as manager_ID
		from
			employees e
		join dept_emp de on
			e.emp_no = de.emp_no
		where
			e.emp_no = 110022
		group by
			e.emp_no) as c
union
	select
		d.*
	from
		(
		select
			e.emp_no as employee_ID,
			MIN(de.dept_no) as department_code,
			(
			select
				emp_no
			from
				dept_manager
			where
				emp_no = 110022) as manager_ID
		from
			employees e
		join dept_emp de on
			e.emp_no = de.emp_no
		where
			e.emp_no = 110039
		group by
			e.emp_no) as d) as u;

SELECT 
    *
FROM
    emp_manager;

SELECT 
    t.emp_no,
    t.title,
    (SELECT 
            ROUND(AVG(s.salary), 2)
        FROM
            salaries s
        WHERE
            s.emp_no = t.emp_no) avg_salary
FROM
    titles t
join salaries s on
	s.emp_no = t.emp_no
where
t.title in ('Staff', 'Engineer')
group by
	t.emp_no
order by
avg_salary desc;

/* ============================= */

SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

truncate table emp_manager;

SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);

SELECT 
    *
FROM
    emp_manager;

SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;

select
	distinct
	e1.*
from
	emp_manager e1
join
    emp_manager e2
on
	e1.emp_no = e2.manager_no;
	# group by e1.manager_no;

/* ============================= */
create view v_avg_salary as
select
	round(avg(s.salary), 2)
from
	salaries s
join dept_manager e 
on
	e.emp_no = s.emp_no;

SELECT 
    *
FROM
    v_avg_salary;

CREATE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2) AS avg_salary
    FROM
        salaries s
    WHERE
        s.emp_no IN (10002 , 10005, 10007)
            AND YEAR(s.from_date) BETWEEN 1991 AND 1996
;

SELECT 
    *
FROM
    v_manager_avg_salary;

/* ============================= */

use employees;

delimiter $$
$$
create procedure employees.first_1k_row()
begin
	select * from employees
	limit 1000;
end
$$
delimiter ;

call first_1k_row();

delimiter $$
$$
create procedure employees.avg_salary()
begin
	select avg(salary) as avg_salary from salaries;
end
$$
delimiter ;

call avg_salary;

SELECT 
    first_name, last_name
FROM
    employees;

set @emp_no = null;
call emp_info("Aruna", "Journel", @emp_no);
SELECT @emp_no;

/* ============================= */
delimiter $$
$$ 
create function employees.emp_info(p_first_name varchar(255),
p_last_name varchar(255)) returns decimal(10, 2)
deterministic no sql reads sql data -- or else ERROR 

begin
	declare v_max_from_date date;
	declare v_salary decimal(10, 2);

select 
	max(s.from_date)
	into
	v_max_from_date
from
	employees e
join salaries s on
	e.emp_no = s.emp_no
where
	p_first_name = e.first_name
	and p_last_name = e.last_name;

select 
	max(s.salary)
	into
	v_salary
from
	employees e
join salaries s on
	e.emp_no = s.emp_no
where
	p_first_name = e.first_name
	and p_last_name = e.last_name
	and s.from_date = v_max_from_date;

return v_salary;
end $$

select emp_info("Aruna", "Journel");

# set @var1 = 'Diana';
# select @var1;

/* ============================= */

use employees;
select employees.hire_date, date_format(now(), '%Y-%m-%d') from employees;

select curdate();

delimiter $$
create trigger trig_hire_date  
before insert on employees
for each row  
begin  
    if new.hire_date > curdate() then     
        set new.hire_date = curdate();     
    end if;  
end $$
delimiter ;

insert into employees values('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  
insert into employees values('999905', '1971-01-31', 'Johnny', 'John', 'M', '2025-09-13');

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

/* ============================= */

SELECT 
    *
FROM
    salaries s
WHERE
    s.salary > 89000;

create index i_salary on salaries (salary);

create index i_from_date on dept_emp(from_date);

create index i_composite_salary on salaries(emp_no, salary);

/* ============================= */

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;

-- -- -- -- -- --

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary),
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) >= 30000 THEN 'Higher raise than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) < 30000 THEN 'NOT - LOWER raise than $30,000'
    END
FROM
    employees e
        RIGHT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no
;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    de.to_date,
    CASE
        WHEN MAX(de.to_date) > CURDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY e.emp_no
LIMIT 100
;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 10005;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) <= 10000 THEN 'insignificant'
        WHEN MAX(s.salary) - MIN(s.salary) > 10000 THEN 'significant'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no , e.first_name , e.last_name , e.hire_date
ORDER BY dm.emp_no ASC;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(dm.to_date),
    IF(MAX(dm.to_date) >= '2025-01-01',
        'Currently working',
        'No longer with the company') AS current_status
FROM
    employees e
        JOIN
    dept_emp dm ON dm.emp_no = e.emp_no
GROUP BY e.emp_no , e.first_name , e.last_name
LIMIT 10;

/* ============================= */

select e.emp_no, dept_no, row_number() over(order by e.emp_no) as row_numbers
from employees e
join dept_manager dm on dm.emp_no = e.emp_no;

select *, row_number() over(partition by first_name order by last_name) as row_numbers
from employees e;

SELECT 
    dm.emp_no, s.salary,
    row_number() over() as num_row,
    row_number() over (partition by emp_no order by salary) as num_row2
FROM
    salaries s
        JOIN
    dept_manager dm ON dm.emp_no = s.emp_no
order by num_row, dm.emp_no, salary asc;

SELECT 
    dm.emp_no, s.salary,
    row_number() over(partition by emp_no ORDER BY salary asc) as num_row,
    row_number() over (partition by emp_no ORDER BY salary DESC) as num_row2
FROM
    salaries s
        JOIN
    dept_manager dm ON dm.emp_no = s.emp_no
order by salary;

select t.emp_no, t.title, s.salary, row_number() over(partition by t.emp_no) as row_num1,
row_number() over(partition by t.emp_no order by salary desc) as row_num2
from titles t
join salaries s on s.emp_no = t.emp_no
where title = 'Staff'
and t.emp_no <= 10006
order by t.emp_no, salary, row_num1;

select *, row_number() over(w) as row_num
from employees
window w as (partition by first_name order by emp_no);

SELECT 
    e.emp_no, MAX(s.salary) AS max_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;

-- -- -- -- -- -- 

select * from (select *,  
row_number() over(w) as row_num
from salaries s
window w as (partition by s.emp_no order by salary asc)) as t
group by emp_no;

select * from (select *,  
row_number() over(partition by s.emp_no order by salary asc) as row_num
from salaries s) as t
where row_num = 1;

SELECT 
    *, MIN(salary) AS min_salary
FROM
    salaries
GROUP BY emp_no
ORDER BY emp_no;

select * from (select *,  
row_number() over(w) as row_num
from salaries s
window w as (partition by s.emp_no order by salary asc)) as t
where row_num = 1;


select * from (select *,  
row_number() over(w) as row_num
from salaries s
window w as (partition by s.emp_no order by salary asc)) as t
where row_num = 2;

SELECT a.emp_no, 
       MIN(salary) AS min_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER (PARTITION BY s.emp_no ORDER BY salary) AS row_num
	FROM
		dept_manager dm
	JOIN 
	    salaries s ON dm.emp_no = s.emp_no) a
GROUP BY a.emp_no;

SELECT 
    dm.emp_no, MIN(s.salary) AS min_salary
FROM
    dept_manager dm
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY dm.emp_no;

select exp.emp_no, exp.salary as max_salary from (select dm.emp_no, s.salary, row_number() over(w) as max_salary
from dept_manager dm join salaries s on dm.emp_no = s.emp_no
window w as (partition by dm.emp_no order by s.salary desc)) exp
group by exp.emp_no;

select a.emp_no, a.salary as third_max_salary from ( select dm.emp_no, s.salary, row_number() over(partition by dm.emp_no order by s.salary desc) as row_num
from dept_manager dm join salaries s on dm.emp_no = s.emp_no) as a
where a.row_num = 3;

/* ============================= */

select *, rank() over(partition by emp_no order by salary desc) from salaries
where emp_no = 10560;

SELECT 
    s.emp_no, COUNT(salary) AS no_of_salary_contracts
FROM
    salaries s
        JOIN
    dept_manager dm ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

select row_number() over() as row_num, s.emp_no, s.salary, rank() over(order by salary desc) as rank_num
from salaries s
where s.emp_no = 10560;

select row_number() over() as row_num, s.emp_no, s.salary, dense_rank() over(order by salary desc) as rank_num
from salaries s
where s.emp_no = 10560;

SELECT 
    dm.dept_no,
    d.dept_name,
    dm.emp_no,
    rank() over w as department_salary_ranking,
    s.salary,
    s.from_date as salary_from_date,
    s.to_date as salary_to_date,
    dm.from_date as dept_manager_from_date,
    dm.to_date as dept_manager_to_date
FROM
    dept_manager dm
join salaries s on dm.emp_no = s.emp_no
and s.from_date between dm.from_date and dm.to_date
and s.to_date between dm.from_date and dm.to_date
join departments d on dm.dept_no = d.dept_no
window w as (partition by dm.dept_no order by s.salary desc)
;

select s.emp_no, s.salary, rank() over(partition by s.emp_no order by s.salary desc) as rank_num
from salaries s
join employees e on s.emp_no = e.emp_no
where s.emp_no between 10500 and 10600
;

select s.emp_no, s.salary, e.hire_date, s.from_date, YEAR(s.from_date) - YEAR(e.hire_date) AS years_from_start, dense_rank() over w as rank_num
from salaries s
join employees e on s.emp_no = e.emp_no
where s.emp_no between 10500 and 10600
and timestampdiff(year, hire_date, from_date) > 3
window w as (partition by s.emp_no order by s.salary desc);

/* select s.emp_no, min(e.hire_date), s.from_date, max(s.to_date)#,  substring(max(s.to_date), 1, 4),  substring(min(e.hire_date), 1, 4)
from salaries s
join employees e on e.emp_no = s.emp_no
group by s.emp_no
having  substring(max(s.to_date), 1, 4) -  substring(min(e.hire_date), 1, 4) > 3
limit 100; */

select s.emp_no, rank() over(partition by s.emp_no order by s.salary desc) as employee_salary_sanking, s.salary
from salaries s
where s.emp_no between 10001 and 10006; 

select e.emp_no, e.hire_date, s.salary, s.from_date, dense_rank() over(partition by s.emp_no order by s.salary desc) as employee_salary_ranking
from salaries s
join employees e on s.emp_no = e.emp_no
where s.emp_no in ('10001', '10002', '10003')
and year(s.from_date) < 2000
order by e.emp_no asc;

select s.emp_no, s.salary, 
lag(s.salary) over w as previous_salary,
lead(s.salary) over w as next_salary,
s.salary - lag(s.salary) over w as diff_current_previous_salary,
lead(s.salary) over w - s.salary as diff_next_current
from salaries s
where s.emp_no between 10500 and 10600
and s.salary >= 80000
window w as (partition by s.emp_no order by s.salary asc)
;

select emp_no, salary,
lag(s.salary) over w as previous_salary,
lag(s.salary, 2) over w as second_previous_salary,
lead(s.salary) over w as next_salary,
lead(s.salary, 2) over w as second_next_salary
from salaries s
window w as (partition by s.emp_no order by s.salary asc)
limit 1000;

select s.emp_no, salary, 
lag(salary) over w as previous_salary,
lead(salary) over w as next_salary,
salary - lag(salary) over w as diff_salary_current_previous,
 lead(salary) over w - salary as diff_salary_next_current
from salaries s
where s.emp_no between 10003 and 10008
and s.salary < 70000
window w as (partition by emp_no order by salary asc);

SELECT 
    emp_no, 
    salary,
    lag(salary, 3) over w as _before_previous_salary,
    lead(salary, 3) over w as _after_next_salary 
FROM
    salaries
window w as (partition by emp_no order by salary asc);

# select sysdate(), curdate(), now();

-- 10001	60117	1986-06-26	1987-06-26
-- 10002	65828	1996-08-03	1997-08-03
-- 10003	40006	1995-12-03	1996-12-02

SELECT 
    emp_no, salary, from_date, to_date, t.rn
FROM
    (SELECT 
        s1.*, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY from_date ASC) AS rn
    FROM
        salaries s1) t
where rn = 1;

/* SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date; */

/* ============================= */

select t.emp_no, t.salary, t.dept_name, t.avg_salary from (select de.emp_no, s.salary, d.dept_name, row_number() over(partition by de.emp_no order by de.from_date desc) as rank_num ,
avg(salary) over (partition by d.dept_name) as avg_salary
from dept_emp de
join salaries s on de.emp_no = s.emp_no
join departments d on d.dept_no = de.dept_no
where de.from_date > '2000-01-01' and de.to_date < '2002-01-01') t
where t.rank_num = 1;

/* select de.emp_no, s.salary, d.dept_name, row_number() over(partition by de.emp_no order by de.from_date desc) as rank_num ,
avg(s.salary)
from dept_emp de
join salaries s on de.emp_no = s.emp_no
join departments d on d.dept_no = de.dept_no
where de.from_date > '2000-01-01' and de.to_date < '2002-01-01'
group by de.emp_no; */


SELECT 
    s.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS latest_from
    FROM
        salaries
    GROUP BY emp_no) t ON s.emp_no = t.emp_no
        AND s.from_date = t.latest_from;

/* ============================= */
# 1
with CTE_salary as (
	select e.emp_no, e.first_name, e.last_name, s.salary
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where gender = 'M' 
), 
CTE_global_avg as (
	select avg(salary) as global_salary_average from salaries
)
select count(c.emp_no) # c.emp_no, c.first_name, c.last_name, c.salary, g.global_salary_average
from CTE_salary c
join CTE_global_avg g on c.salary <= g.global_salary_average;

# 2
WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;

SELECT 
    COUNT(*)
FROM
    (SELECT 
        e.emp_no,
            e.gender,
            s.salary,
            (SELECT 
                    AVG(salary)
                FROM
                    salaries) avg_global_salary
    FROM
        salaries s
    JOIN employees e ON e.emp_no = s.emp_no
    WHERE
        gender = 'M'
            AND s.salary < (SELECT 
                AVG(salary)
            FROM
                salaries)) AS salaries;

SELECT 
    SUM(CASE
        WHEN s.salary < a.avg_salary THEN 1
        ELSE 0
    END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    (SELECT 
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';
    

SELECT 
    COUNT(*)
FROM
    (SELECT 
        COUNT(DISTINCT e.emp_no) AS no_male_employees_below_avg
    FROM
        employees e
    CROSS JOIN salaries s
    WHERE
        e.emp_no = s.emp_no AND e.gender = 'M'
            AND s.salary < (SELECT 
                AVG(salary)
            FROM
                salaries)
    GROUP BY e.emp_no) AS sal;


# 4.b:
WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;

/* ============================= */

with cte as (
select count(*) as no_f_salaries_below_avg from employees e
join salaries s
on e.emp_no = s.emp_no
where gender = 'F'
and s.salary < (select avg(salary) from salaries)
group by e.emp_no) 
,
cte2 as (
select count(*) as no_of_f_salary_contracts from salaries s
join employees e on s.emp_no = e.emp_no
where gender = 'F'
)
select count(cte.no_f_salaries_below_avg), cte2.no_of_f_salary_contracts
from cte, cte2;

/* ============================= */

with cte_f_highest_salary as (
select employees.emp_no as emp_no, max(salary) as f_highest_salary from salaries
join employees on employees.emp_no = salaries.emp_no and gender = 'F'
group by employees.emp_no) 
,
cte_average_salary as (
select avg(salary) as average_salary from salaries)
select count(*) /*, cte_average_salary.average_salary*/ from cte_f_highest_salary, cte_average_salary
where f_highest_salary > average_salary;

# version 2. 
# select sum(case when f_highest_salary > average_salary then 1 else 0 end) from cte_f_highest_salary, cte_average_salary;

/* ============================= */

with cte_avg_salary as (
	select avg(salary) as avg_sal from salaries
), cte_m_highest_salary as (
	select e.emp_no, max(s.salary) as max_sal from employees e
    join salaries s on e.emp_no = s.emp_no and gender = 'M'
    group by e.emp_no
)
# select sum(case when cte_m_highest_salary.max_sal < cte_avg_salary.avg_sal then 1 else 0 end) as no_m_max_salary_below_avg from cte_avg_salary, cte_m_highest_salary;
select count(*) as no_m_max_salary_below_avg from cte_avg_salary, cte_m_highest_salary
where cte_m_highest_salary.max_sal < cte_avg_salary.avg_sal;

/* ============================= */

with no_f_salaries_below_avg as (
    select e.emp_no, s.salary as salary
    from employees e join salaries s on e.emp_no = s.emp_no and gender = 'F'
    where s.salary <= (select avg(salary) from salaries)
), total as (
select count(salary) as total from salaries)
select count(case when c.salary then c.salary else null end) as no_f_salaries_below_avg, total.total as total_no_of_salary_contracts 
from no_f_salaries_below_avg c
cross join total;

with no_m_salaries_above_avg as (
    select e.emp_no, s.salary as salary
    from employees e join salaries s on e.emp_no = s.emp_no and gender = 'M'
    where s.salary > (select avg(salary) from salaries)
), total as (
select count(salary) as total from salaries)
select count(case when c.salary then c.salary else null end) as no_m_salaries_above_avg, total.total as total_no_of_salary_contracts 
from no_m_salaries_above_avg c
cross join total;

with highest_f_salaries_below_total_avg as (
    select e.emp_no, s.salary as salary
    from employees e join salaries s on e.emp_no = s.emp_no and gender = 'F'
    group by e.emp_no
    having max(s.salary) <= (select avg(salary) from salaries)
), total as (
select count(salary) as total from salaries)
select count(case when c.salary then c.salary else null end) as highest_f_salaries_below_total_avg, total.total as total_no_of_salary_contracts 
from highest_f_salaries_below_total_avg c
cross join total;

/* ============================= */

create temporary table male_max_salaries
select salaries.emp_no, max(salary) as highest_contract from salaries
join employees on salaries.emp_no = employees.emp_no and gender = 'M'
group by salaries.emp_no;

select * from male_max_salaries;

create temporary table dates
select 
	now() as `now`, 
    date_sub(now(), interval 2 month) `two_months_earlier`,
    date_add(now(), interval 2 year) `two_years_later`;

select * from dates;

with cte as (
	select 
	now() as `now`, 
    date_sub(now(), interval 2 month) `two_months_earlier`,
    date_add(now(), interval 2 year) `two_years_later`
) select * from cte union all select * from dates
;

create temporary table salaries_adjusted_for_inflation as 
select 
    e.emp_no,
    s.salary,
 round(case
        when s.from_date between "1970-01-01" and "1989-12-31" then round(salary, 2) * 6.5
        when s.from_date between "1990-01-01" and "1999-12-31" then round(salary, 2) * 2.8
        else round(salary, 2) * 3
    end, 2) as inflation_adjusted_salary,
    s.from_date,
    s.to_date
from employees e join salaries s on e.emp_no = s.emp_no;

select * from salaries_adjusted_for_inflation;




