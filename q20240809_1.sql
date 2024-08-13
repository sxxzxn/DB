START TRANSACTION;
SELECT * FROM dept_emp;
UPDATE dept_emp SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR),
	to_date = ADDDATE(to_date, INTERVAL 20 YEAR)
WHERE to_date <> '9999-01-01'
;




SELECT * FROM dept_emp;
UPDATE dept_emp SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR)
WHERE to_date = '9999-01-01'
;
ROLLBACK;
COMMIT;
#
START TRANSACTION;
SELECT * FROM dept_manager;
UPDATE dept_manager SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR),
	to_date = ADDDATE(to_date, INTERVAL 20 YEAR)
WHERE to_date <> '9999-01-01'
;
SELECT * FROM dept_manager;
UPDATE dept_manager SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR)
WHERE to_date = '9999-01-01'
;
COMMIT;
ROLLBACK;
#
START TRANSACTION;
SELECT * FROM employees;
UPDATE employees SET
	birth_date = ADDDATE(birth_date, INTERVAL 20 YEAR),
	hire_date = ADDDATE(hire_date, INTERVAL 20 YEAR)
;
SELECT * FROM employees;
ROLLBACK;
COMMIT;
#
START TRANSACTION;
SELECT * FROM employees_comp4k;
UPDATE employees_comp4k SET
	birth_date = ADDDATE(birth_date, INTERVAL 20 YEAR),
	hire_date = ADDDATE(hire_date, INTERVAL 20 YEAR)
;
SELECT * FROM employees_comp4k;
ROLLBACK;
COMMIT;
#
START TRANSACTION;
SELECT * FROM employees_comp8k;
UPDATE employees_comp8k SET
	birth_date = ADDDATE(birth_date, INTERVAL 20 YEAR),
	hire_date = ADDDATE(hire_date, INTERVAL 20 YEAR)
;
SELECT * FROM employees_comp8k LIMIT 5;
ROLLBACK;
COMMIT;
#
START TRANSACTION;
SELECT * FROM salaries;
UPDATE salaries SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR),
	to_date = ADDDATE(to_date, INTERVAL 20 YEAR)
WHERE to_date <> '9999-01-01'
;
SELECT * FROM salaries LIMIT 20;
UPDATE salaries SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR)
WHERE to_date = '9999-01-01'
;
ROLLBACK;
COMMIT;
#
START TRANSACTION;
SELECT * FROM titles;
UPDATE titles SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR),
	to_date = ADDDATE(to_date, INTERVAL 20 YEAR)
WHERE to_date <> '9999-01-01'
;
SELECT * FROM titles LIMIT 200;
UPDATE titles SET
	from_date = ADDDATE(from_date, INTERVAL 20 YEAR)
WHERE to_date = '9999-01-01'
;
COMMIT;
ROLLBACK;