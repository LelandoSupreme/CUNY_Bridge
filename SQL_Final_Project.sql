-- Final Project, CUNY SQL Bridge Course Summer 2016
-- Leland Randles
-- building_energy database

-- 1. Create new database called BuildingEnergy.  This was done using "Create new schema in the 
-- connected server icon (see presentation).  I named the schema "building_energy because my 
-- "lower_case_table_names" system variable is set such that all schemas and tables are lower case, 
-- and I felt "building_energy" was more readable than buildingenergy.  I spent 30 minutes trying to
-- figure out how to change this system variable, but couldn't figure it out.

-- Drop tables if they exist.  This is necessary because the assignment asked that the SQL script
-- be self-contained so that if it run again, it re-creates the database.
DROP TABLE IF EXISTS energy_categories;
DROP TABLE IF EXISTS energy_types;
DROP TABLE IF EXISTS buildings; 
DROP TABLE IF EXISTS buildings_energy_types; 

-- 2. Create energy_categories table
CREATE TABLE energy_categories (energy_category_id int PRIMARY KEY, 
	energy_category varchar(20) NOT NULL UNIQUE);

-- 2. Populate energy_categories table
INSERT INTO energy_categories (energy_category_id, energy_category) VALUES (1, 'Fossil'); 
INSERT INTO energy_categories (energy_category_id, energy_category) VALUES (2, 'Renewable'); 

--To visually inspect data
SELECT * FROM energy_categories;

-- 2. Create energy_types table
CREATE TABLE energy_types (energy_type_id int PRIMARY KEY,   
	energy_type varchar(20) NOT NULL UNIQUE,  
	energy_category_id int NOT NULL REFERENCES energy_categories(energy_category_id));

-- 2. Populate energy_types table
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (1, 'Electricity', 1); 
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (2, 'Gas', 1); 
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (3, 'Steam', 1); 
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (4, 'Fuel Oil', 1); 
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (5, 'Solar', 2); 
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (6, 'Wind', 2); 

-- To visually inspect data
SELECT * FROM energy_types;

-- 3. Write join statement that shows the energy categories and associated energy types.
SELECT c.energy_category, t.energy_type
FROM energy_categories c inner join energy_types t on 
	c.energy_category_id = t.energy_category_id

-- 4. Add a table called buildings. There should be a many-to-many 
-- relationship between buildings and energy_types. Though the subseqent 
-- questions in the final project don't require it, because this is a
-- many-to-many relationship, I am going to create two tables, a buildings
-- table and a buildings_energy_types table to link buildings and energy_types.
CREATE TABLE buildings (building_id int PRIMARY KEY, 
	building_name varchar(50) NOT NULL);

-- 4. Poulate buildings table
INSERT INTO buildings (building_id, building_name) VALUES (1, 'Empire State Building'); 
INSERT INTO buildings (building_id, building_name) VALUES (2, 'Chrysler Building'); 
INSERT INTO buildings (building_id, building_name) VALUES (3, 'Borough of Manhattan Community College'); 

-- To visually inspect data
SELECT * FROM buildings;

-- 4. Create buildings_energy_types to link buildings and energy_types; set composite primary key
CREATE TABLE buildings_energy_types (building_id int NOT NULL REFERENCES buildings(building_id), 
	energy_type_id int NOT NULL REFERENCES energy_types(energy_type_id), 
	CONSTRAINT pk_buildings_energy_types PRIMARY KEY (building_id, energy_type_id));

-- 4. Populate buildings_energy_types
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (1, 1); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (1, 2); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (1, 3); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (2, 1); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (2, 3); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (3, 1); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (3, 3); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (3, 5); 

-- To visually inspect data
SELECT * FROM buildings_energy_types;

-- 5. Write a join statement that shows the buildings and their associated energy types
select b.building_name, e.energy_type
from buildings b inner join buildings_energy_types l on 
	b.building_id = l.building_id 
    inner join energy_types e on 
    l.energy_type_id = e.energy_type_id
order by b.building_name, e.energy_type

-- 6. Add information to database per assignment. Row(s) must be added 
-- to energy_types, buildings, and buildings_energy_types.
INSERT INTO energy_types (energy_type_id, energy_type, energy_category_id) VALUES (7, 'Geothermal', 2); 
INSERT INTO buildings (building_id, building_name) VALUES (4, 'Bronx Lions House'); 
INSERT INTO buildings (building_id, building_name) VALUES (5, 'Brooklyn Childrens Museum'); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (4, 7); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (5, 1); 
INSERT INTO buildings_energy_types (building_id, energy_type_id) VALUES (5, 7); 

-- To visually inspect data
SELECT * FROM energy_types;
SELECT * FROM buildings;
SELECT * FROM buildings_energy_types;

-- 7. Write a SQL query that displays all of the buildings that use Renewable Energies
-- (it appears from the sample output on the assignment you also want the energy type displayed)
SELECT b.building_name, e.energy_type, c.energy_category
FROM buildings b inner join buildings_energy_types t on 
	b.building_id = t.building_id 
    inner join energy_types e on 
    t.energy_type_id = e.energy_type_id 
    inner join energy_categories c on 
    e.energy_category_id = c.energy_category_id 
WHERE c.energy_category = 'Renewable'

-- 8. Write a SQL query that shows the frequency with which energy types are used in various buildings 
SELECT e.energy_type, count(e.energy_type) as `count`
FROM energy_types e inner join buildings_energy_types t on 
	e.energy_type_id = t.energy_type_id
group by e.energy_type
order by count(e.energy_type) desc

-- 9.b.  Entity Relationship Diagram
