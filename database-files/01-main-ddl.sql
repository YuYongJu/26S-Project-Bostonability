CREATE DATABASE IF NOT EXISTS bostonability;
USE bostonability;
 
CREATE TABLE permission (
    permission_id   INT PRIMARY KEY AUTO_INCREMENT,
    action_type     VARCHAR(50)  NOT NULL,
    resource        VARCHAR(100) NOT NULL
);
 
CREATE TABLE role (
    role_id          INT PRIMARY KEY AUTO_INCREMENT,
    role_name        VARCHAR(50)  NOT NULL,
    role_description VARCHAR(255)
);
 
CREATE TABLE disability (
    disability_id   INT PRIMARY KEY AUTO_INCREMENT,
    disability_name VARCHAR(100) NOT NULL
);
 
CREATE TABLE issue_type (
    issue_type_id   INT PRIMARY KEY AUTO_INCREMENT,
    issue_type_name VARCHAR(100) NOT NULL,
    issue_category  VARCHAR(100)
);
 
CREATE TABLE location (
    location_id       INT PRIMARY KEY AUTO_INCREMENT,
    street_name       VARCHAR(150),
    neighborhood_name VARCHAR(100),
    zip_code          VARCHAR(10)
);
 
CREATE TABLE obstructions (
    obstruction_id   INT PRIMARY KEY AUTO_INCREMENT,
    obstruction_name VARCHAR(100) NOT NULL,
    obstruction_desc VARCHAR(255),
    severity_level   INT
);
 
CREATE TABLE `user` (
    user_id                 INT PRIMARY KEY AUTO_INCREMENT,
    first_name              VARCHAR(50)  NOT NULL,
    last_name               VARCHAR(50)  NOT NULL,
    user_email              VARCHAR(100) NOT NULL UNIQUE,
    phone_number            VARCHAR(20),
    preferred_language      VARCHAR(50),
    demographics_age        INT,
    demographics_gender     VARCHAR(50),
    demographics_ethinicity VARCHAR(100)
);
 
CREATE TABLE role_permission (
    role_id       INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id)       REFERENCES role(role_id)             ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permission(permission_id) ON DELETE CASCADE
);
 
CREATE TABLE user_role (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES `user`(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(role_id)    ON DELETE CASCADE
);
 
CREATE TABLE user_disability (
    user_id       INT,
    disability_id INT,
    PRIMARY KEY (user_id, disability_id),
    FOREIGN KEY (user_id)       REFERENCES `user`(user_id)             ON DELETE CASCADE,
    FOREIGN KEY (disability_id) REFERENCES disability(disability_id)   ON DELETE CASCADE
);
 
CREATE TABLE location_obstruction (
    location_id    INT,
    obstruction_id INT,
    PRIMARY KEY (location_id, obstruction_id),
    FOREIGN KEY (location_id)    REFERENCES location(location_id)       ON DELETE CASCADE,
    FOREIGN KEY (obstruction_id) REFERENCES obstructions(obstruction_id) ON DELETE CASCADE
);
 
CREATE TABLE disability_obstruction (
    disability_id  INT,
    obstruction_id INT,
    PRIMARY KEY (disability_id, obstruction_id),
    FOREIGN KEY (disability_id)  REFERENCES disability(disability_id)    ON DELETE CASCADE,
    FOREIGN KEY (obstruction_id) REFERENCES obstructions(obstruction_id) ON DELETE CASCADE
);
 
CREATE TABLE report (
    report_id          INT PRIMARY KEY AUTO_INCREMENT,
    report_date        DATE         NOT NULL,
    report_type        VARCHAR(50),
    report_status      VARCHAR(50)  NOT NULL,
    past_report_status VARCHAR(50),
    urgency            VARCHAR(50),
    description        TEXT,
    location_id        INT,
    user_id            INT,
    FOREIGN KEY (location_id) REFERENCES location(location_id) ON DELETE SET NULL,
    FOREIGN KEY (user_id)     REFERENCES `user`(user_id)       ON DELETE SET NULL
);
 
CREATE TABLE accessibility_report (
    report_id     INT PRIMARY KEY,
    issue_type_id INT NOT NULL,
    report_date   DATE         NOT NULL,
    report_status VARCHAR(50)  NOT NULL,
    photo_url     VARCHAR(255),
    user_id       INT NOT NULL,
    FOREIGN KEY (report_id)     REFERENCES report(report_id)         ON DELETE CASCADE,
    FOREIGN KEY (issue_type_id) REFERENCES issue_type(issue_type_id) ON DELETE RESTRICT,
    FOREIGN KEY (user_id)       REFERENCES `user`(user_id)           ON DELETE CASCADE
);