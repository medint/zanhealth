CREATE DATABASE IF NOT EXISTS `zanhealth_test`;
USE `zanhealth_test`;

DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `facilities`;
DROP TABLE IF EXISTS `models`;
DROP TABLE IF EXISTS `location`;
DROP TABLE IF EXISTS `needs`;
DROP TABLE IF EXISTS `items`;
DROP TABLE IF EXISTS `items_history`;
DROP TABLE IF EXISTS `work_requests`;
DROP TABLE IF EXISTS `work_request_comments`;


/*
    Specifies different types of roles
*/
CREATE TABLE roles (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(45) NOT NULL
);

/*
    Specifies the different users and details
*/
CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(60) NOT NULL,
    role_id INT,
	created DATETIME,
	modified DATETIME,
    telephone_num INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

/*
   specifies the different facilities/hospitals
*/
CREATE TABLE facilities (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL
);


/*
   specifies different models of an item 
*/
CREATE TABLE models (
	id INT PRIMARY KEY AUTO_INCREMENT,
	model_name VARCHAR (255) NOT NULL,
	manufacturer_name VARCHAR (255)	NOT NULL,
	vendor_name VARCHAR(255) 
);


/*
  specifies a location in a facility
*/
CREATE TABLE location  (
	id INT PRIMARY KEY AUTO_INCREMENT,
	room VARCHAR (100),
	floor INT NOT NULL,
	building VARCHAR(50),
    facilities_id INT,
    FOREIGN KEY (facilities_id) REFERENCES facilities(id)
);


/*
   specifies a need request
*/
CREATE TABLE needs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(45) NOT NULL,
    location_id INT,
    model_id INT,
	quantity INT NOT NULL,
	urgency ENUM ('HIGH', 'MEDIUM','LOW'),
	reason TEXT,
	remarks TEXT,
	stage ENUM ('OPEN', 'IN SHIPMENT','CLOSED'),
	date_requested DATE,
    user_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (model_id) REFERENCES models(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


/*
    specifies items in the hospital / inventory
*/
CREATE TABLE items (
	id INT PRIMARY KEY AUTO_INCREMENT,
	domain ENUM ('U-MM','P-CC','P-PHL'),
	tag INT NOT NULL,
	category VARCHAR(255) NOT NULL,
    model_id INT,
	serial_number VARCHAR(45),
	year_manufactured INT,
	funding VARCHAR (45),
	date_received DATE,
	warranty_expire DATE,
	contract_expire DATE,
	warranty_notes TEXT,
	service_agent VARCHAR(45),
    location_id INT,
	item_type ENUM('Biomedical'),
	price INT,
	FOREIGN KEY (model_id) REFERENCES models(id),
    FOREIGN KEY (location_id) REFERENCES location(id)
);

/*
    specifies the history of the item - the latest entry according to the datetime field has the latest status
*/
CREATE TABLE items_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    datetime DATETIME,
    status ENUM ('Fully Functional',  'Not Functional', 'Needs Major Repair', 'Needs Minor Repair', 'Decommissioned', 'Disposed') NOT NULL,
    utilization ENUM ('Normal', 'No Utilization', 'Very High', 'Very Low','Decomissioned', 'Disposed') NOT NULL,
    remarks TEXT,
    FOREIGN KEY (item_id) REFERENCES items(id)
);


/*
   specifies a work request filed by a user 
*/
CREATE TABLE work_requests (
	id INT PRIMARY KEY AUTO_INCREMENT,
	date_requested DATETIME NOT NULL,
	date_expire DATETIME,
	date_completed DATETIME,
 	request_type ENUM ('Breakdown','Preventative'),
    item INT,
 	cost INT NOT NULL,
 	description TEXT,
 	status ENUM ('Opened', 'Closed'),
 	owner_id INT,
    requester_id INT,
 	cause_description TEXT,
 	action_taken TEXT,
 	prevention_taken TEXT,
    FOREIGN KEY (item) REFERENCES items(id),
    FOREIGN KEY (requester_id) REFERENCES users(id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

/*
    specifies a work request comment
*/
CREATE TABLE work_request_comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    datetime_stamp TIMESTAMP,
    work_request_id INT,
    user_id INT,
    comment_text TEXT,
    FOREIGN KEY (work_request_id) REFERENCES work_requests(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);










