DROP DATABASE IF EXISTS ngo_db;
CREATE DATABASE IF NOT EXISTS ngo_db;
USE ngo_db;

CREATE TABLE IF NOT EXISTS Role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Permission (
    permission_id INT PRIMARY KEY,
    action_type VARCHAR(50) NOT NULL,
    resource VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Disability (
    disability_id INT PRIMARY KEY,
    disability_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Obstructions (
    obstruction_id INT PRIMARY KEY,
    obstruction_name VARCHAR(100) NOT NULL,
    obstruction_desc VARCHAR(255),
    severity_level INT
);

CREATE TABLE IF NOT EXISTS Issue_Type (
    issue_type_id INT PRIMARY KEY,
    issue_type_name VARCHAR(100) NOT NULL,
    issue_category VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS User (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    preferred_language VARCHAR(50),
    demographics_age INT,
    demographics_gender VARCHAR(50),
    demographics_ethnicity VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Location (
    location_id INT PRIMARY KEY,
    street_name VARCHAR(255) NOT NULL,
    neighborhood_name VARCHAR(100),
    zip_code VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Report (
    report_id INT PRIMARY KEY,
    report_date DATETIME,
    report_type VARCHAR(50),
    report_status VARCHAR(50),
    urgency INT,
    description VARCHAR(255),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE IF NOT EXISTS Accessibility_Report (
    report_id INT PRIMARY KEY,
    issue_type_id INT,
    report_status VARCHAR(50),
    photo_url VARCHAR(255),
    user_id INT,
    FOREIGN KEY (report_id) REFERENCES Report(report_id),
    FOREIGN KEY (issue_type_id) REFERENCES Issue_Type(issue_type_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE IF NOT EXISTS Accessibility_Ticket (
    ticket_id INT PRIMARY KEY,
    ticket_status VARCHAR(50),
    ticket_date DATE,
    ticket_time TIME,
    report_id INT,
    issue_type_id INT,
    FOREIGN KEY (report_id) REFERENCES Report(report_id),
    FOREIGN KEY (issue_type_id) REFERENCES Issue_Type(issue_type_id)
);

CREATE TABLE IF NOT EXISTS User_Role (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE IF NOT EXISTS User_Disability (
    user_id INT,
    disability_id INT,
    PRIMARY KEY (user_id, disability_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (disability_id) REFERENCES Disability(disability_id)
);

CREATE TABLE IF NOT EXISTS Role_Permission (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id),
    FOREIGN KEY (permission_id) REFERENCES Permission(permission_id)
);

CREATE TABLE IF NOT EXISTS Location_Obstruction (
    location_id INT,
    obstruction_id INT,
    PRIMARY KEY (location_id, obstruction_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    FOREIGN KEY (obstruction_id) REFERENCES Obstructions(obstruction_id)
);

CREATE TABLE IF NOT EXISTS Disability_Obstruction (
    disability_id INT,
    obstruction_id INT,
    PRIMARY KEY (disability_id, obstruction_id),
    FOREIGN KEY (disability_id) REFERENCES Disability(disability_id),
    FOREIGN KEY (obstruction_id) REFERENCES Obstructions(obstruction_id)
);