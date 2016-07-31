DROP TABLE IF EXISTS employees;

-- Create the table
CREATE TABLE employees (employee_id int PRIMARY KEY, 
	employee_name varchar(40) NOT NULL UNIQUE, 
    title varchar(60) NOT NULL, 
    supervisor_id int);

-- Populate the table
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (1, 'Jeffrey Sloan', 'CEO', NULL);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (2, 'Cameron Bready', 'CFO', 1);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (3, 'David Mangum', 'COO', 1);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (4, 'Guido Sacchi', 'CIO', 1);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (5, 'David Sheffield', 'CAO', 2);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (6, 'Danny O''Keefe', 'Head of Accounting', 5);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (7, 'Renata Smutna', 'Head of Finance', 2);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (8, 'Jennifer Whyte', 'Controller', 6);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (9, 'Liang Xu', 'Accounting Manager', 8);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (10, 'Vick van Staden', 'Accounting Manager', 8);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (11, 'Barrett Smith', 'VP Pricing', 7);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (12, 'Susan Grubb', 'Director, Finance', 7);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (13, 'Jeff Weekley', 'Director, Finance', 7);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (14, 'Leland Randles', 'Analytics Manager', 11);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (15, 'Justin Roman', 'Pricing Manager', 11);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (16, 'Frank Young', 'SVP of Innovation', 3);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (17, 'Andra Milender', 'SVP Information Technology', 4);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (18, 'Mark Kubik', 'VP, Architecture and Data', 17);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (19, 'Sam Abdelaziz', 'Director, Project Management', 17);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (20, 'Jeff Burke', 'Manager, Product', 3);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (21, 'Gwen Pope', 'Manager, Operations', 23);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (22, 'Samir Khan', 'Director, Sales', 23);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (23, 'Sid Singh', 'President, OpenEdge', 3);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (24, 'David Green', 'Chief Counsel', 1);
INSERT INTO employees (employee_id, employee_name, title, supervisor_id) VALUES (25, 'Felix Solomon', 'Sr Business Analyst', 14);

-- Test to visually inspect data
SELECT * FROM employees;

-- Provide a single SELECT statement that displays the infomation in
-- the table, showing who reports to whom.
SELECT e1.employee_name, e1.title as employee_title, e2.employee_name as supervisor_name, e2.title as supervisor_title
FROM employees e1 LEFT JOIN employees e2 ON 
	e1.supervisor_id = e2.employee_id
ORDER BY e1.employee_id