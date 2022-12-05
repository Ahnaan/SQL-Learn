-- table creation
DROP TABLE student;
CREATE TABLE student (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(30),
    major VARCHAR(30) DEFAULT 'undecided'
); 
DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL;
 
ALTER TABLE student DROP COLUMN gpa;

ALTER TABLE student ADD gpa DECIMAL(3,2);

-- inserting data

INSERT INTO student( student_name,major) VALUES('Jack', 'Biology');
INSERT INTO student( student_name,major) VALUES('Kate', 'Sociology');
SELECT * FROM student;

INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');

-- constraints
NOT NULL
UNIQUE
DEFAULT
AUTO_INCREMENT

-- update and delete
DROP TABLE student_table
CREATE TABLE student_table(
	id INT,
    first_name VARCHAR(20),
    major_sub VARCHAR(20),
    PRIMARY KEY(id)
);
SELECT * FROM student_table;
INSERT INTO student_table VALUES(1,'Jack','Biology');
INSERT INTO student_table VALUES(2, 'Kate', 'Sociology');
INSERT INTO student_table VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student_table VALUES(4, 'Jack', 'Biology');
INSERT INTO student_table VALUES(5, 'Mike', 'Computer Science');

UPDATE student_table SET major_sub = 'Bio' WHERE major_sub = 'Biology';
UPDATE student_table SET major_sub = 'Biochemistry' WHERE major_sub = 'Bio' OR major_sub = 'Chem';
UPDATE student_table SET first_name = 'Tom', major_sub = 'undecided' WHERE id = 1;
UPDATE student_table SET major_sub = 'undecided';

DELETE FROM student_table
WHERE first_name = 'Tom' AND major_sub = 'undecided';
DELETE FROM student_table;

-- basic queries

SELECT first_name FROM student_table;
SELECT first_name, major_sub FROM student_table;
SELECT first_name, major_sub FROM student_table ORDER BY first_name;
SELECT first_name, major_sub FROM student_table ORDER BY first_name DESC;
SELECT * FROM student_table ORDER BY id DESC;
SELECT * FROM student_table ORDER BY id ASC;
SELECT * FROM student_table ORDER BY major_sub, id;
SELECT * FROM student_table ORDER BY major_sub, id DESC;
SELECT * FROM student_table LIMIT 2;
SELECT * FROM student_table ORDER BY id DESC LIMIT 2;
SELECT * FROM student_table WHERE major_sub = 'Biology';
SELECT first_name, major_sub FROM student_table WHERE major_sub = 'Biology' OR major_sub = 'Chemistry' OR first_name = 'Mike';
-- <,>,<=,>=, =,<>, AND, OR
SELECT first_name, major_sub FROM student_table WHERE major_sub <> 'Chemistry';
SELECT first_name, major_sub FROM student_table WHERE id < 3 AND first_name <> 'Jack';
SELECT * FROM student_table WHERE first_name IN ('Claire','Kate','Mike');
SELECT * FROM student_table WHERE major_sub IN ('Sociology','Chemistry','Biology') AND id > 2;

-- company database creation


CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Find all employees
SELECT * FROM employee;
SELECT * FROM client;
-- Find all employees ordered by salary
SELECT * FROM employee ORDER BY salary DESC; 
-- Find all employees ordered by sex and then name
SELECT * FROM employee ORDER BY sex, first_name, last_name;
-- Find the first 5 employees in the table
SELECT * FROM employee LIMIT 5;
-- Find the first and last names of all employees
SELECT first_name, last_name FROM employee;
-- Find the forename and surnames of all employees
SELECT first_name AS forename, last_name AS surname FROM employee;
-- Find out all the different genders
SELECT DISTINCT sex FROM employee;
SELECT DISTINCT branch_id FROM employee;


-- Functions
	-- Find the number of employees
SELECT COUNT(emp_id) FROM employee;    
SELECT COUNT(super_id) FROM employee;
	-- Find the number of female employees born after 1970
SELECT COUNT(emp_id) FROM employee WHERE sex = 'F' AND birth_day > '1970-01-01';
	-- Find the average of all employee's salaries
SELECT AVG(salary) FROM employee;
SELECT AVG(salary) FROM employee WHERE sex = 'M';
	-- Find the sum of all employee's salaries
SELECT SUM(salary) FROM employee;   
	-- Find out how many males and females there are
SELECT COUNT(sex), sex FROM employee GROUP BY sex;    
	-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;
-- Wildcards
	-- % = any # characters, _ = one character

	-- Find any client who are an LLC
SELECT * FROM client WHERE client_name LIKE '%LLC';
	-- Find any branch suppliers whoare in the label business
SELECT * FROM branch_supplier WHERE supplier_name LIKE '%Label%';
	-- Find any employee born in October
SELECT * FROM employee WHERE birth_day LIKE '____-10%';
SELECT * FROM employee WHERE birth_day LIKE '____-02%';
	-- Find any clients who are schools
SELECT * FROM client WHERE client_name LIKE '%School%';

-- Unions
	-- Find a list of employee and branch names
SELECT first_name AS company_names FROM employee UNION SELECT branch_name FROM branch UNION SELECT client_name FROM client;
	-- Find a list of all Clients and branch suppliers' names
SELECT client_name, branch_id FROM client UNION SELECT supplier_name, branch_id FROM branch_supplier;
	-- Find a list of all moneyspent or earned by the company
SELECT salary FROM employee UNION SELECT total_sales FROM works_with;

-- Joins