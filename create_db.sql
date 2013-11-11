CREATE DATABASE IF NOT EXISTS `zanhealth_test`;
USE `zanhealth_test`;

DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `work_requests`;
DROP TABLE IF EXISTS `items`;
DROP TABLE IF EXISTS `models`;
DROP TABLE IF EXISTS `location`;
DROP TABLE IF EXISTS `facilities`;
DROP TABLE IF EXISTS `needs`;

CREATE TABLE roles (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(45) NOT NULL
);

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(60) NOT NULL,
	role_id INT REFERENCES roles(id),
	created DATETIME,
	modified DATETIME
);

CREATE TABLE work_requests (
	id INT PRIMARY KEY AUTO_INCREMENT,
	date_requested DATETIME NOT NULL,
	date_expire DATETIME,
	date_completed DATETIME,
 	request_type ENUM ('Breakdown','Preventative'),
 	item INT REFERENCES items(id),
 	cost INT NOT NULL,
 	description TEXT,
 	status ENUM ('Opened', 'Closed'),
 	owner VARCHAR(45),
 	requester_id INT REFERENCES users(id),
 	cause_description TEXT,
 	action_taken TEXT,
 	prevention_taken TEXT,
 	facility_comments TEXT,
 	engineer_comments TEXT,
 	manager_comments TEXT
);

CREATE TABLE items (
	id INT PRIMARY KEY AUTO_INCREMENT,
	domain ENUM ('U-MM','P-CC','P-PHL'),
	tag INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	model_id INT REFERENCES models(id),
	serial_number VARCHAR(45),
	year_manufactured INT,
	funding VARCHAR (45),
	date_received DATE,
	warranty_expire DATE,
	contract_expire DATE,
	warranty_notes TEXT,
	service_agent VARCHAR(45),
	location_id INT REFERENCES location(id),
	status ENUM ('Fully Functional',  'Not Functional', 'Needs Major Repair', 'Needs Minor Repair', 'Decommissioned', 'Disposed') NOT NULL,
	utilization ENUM ('Normal', 'No Utilization', 'Very High', 'Very Low','Decomissioned', 'Disposed') NOT NULL,
	remarks TEXT,
	item_type ENUM('Biomedical'),
	quantity INT,
	item_spec VARCHAR(45),
	price INT NOT NULL,
	itemscol VARCHAR(45)
);

CREATE TABLE models (
	id INT PRIMARY KEY AUTO_INCREMENT,
	manufacturer_name VARCHAR (255)	NOT NULL,
	vendor_name VARCHAR(255) 
);

CREATE TABLE needs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(45) NOT NULL,
	facility_id INT REFERENCES facility(id),
	location_id INT REFERENCES location(id),
	model_id INT REFERENCES models(id),
	quantity INT NOT NULL,
	urgency ENUM ('HIGH', 'MEDIUM','LOW'),
	reason TEXT,
	remarks TEXT,
	stage ENUM ('OPEN', 'IN SHIPMENT','CLOSED'),
	date_requested DATE,
	user_id INT REFERENCES users(id)
);

CREATE TABLE facilities (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE location  (
	id INT PRIMARY KEY AUTO_INCREMENT,
	floor INT NOT NULL,
	building VARCHAR(50),
	facilities_id INT REFERENCES facilities(id)
);


