##########################################################
## First we will set up a new user account and provide
## it with the permissions needed to query the tables.
## This account can be used from the command line or it
## can be used as the account that our Java program
## use to connect to the database.
## NOTE: these commands can be executed individually at
## the mysql commandline tool or you can execute this
## entire file as a script from within the commandline
## tool.
##
## NOTE: After this script executs, you will be able to log
##       into the MySQL command line interface using the
##       following command:
##
##       mysql -u newbie -ptesting
##
##########################################################

## drop the user if the account already exists
DROP USER IF EXISTS 'newbie'@'localhost';

## Create a new user for the database we will create
## and provide the password
CREATE USER 'newbie'@'localhost' IDENTIFIED BY 'testing';

## give the user full permissions on all tables
## under the classRegistration database (to be created soon)
GRANT ALL ON classRegistration.* TO 'newbie'@'localhost';

## now make those changes effective immediately
FLUSH TABLES;
FLUSH PRIVILEGES;

##########################################################
## Now that the user is created, let's create the database
## and populate it with some initial data
##########################################################

## drop the database if it already exists to prevent errors
DROP DATABASE IF EXISTS classRegistration;

## create the database
CREATE DATABASE classRegistration;

## now that it's created, let's "use" the database as
## the current frame of reference under which all the
## following commands will be executed.
USE classRegistration;

## we will create all the tables first and then populate
## them with data so that we can use the LAST_INSERTED_ID()
## mysql function to capture the value of the AUTO_INCREMENT
## columns and insert it into the corresponding tables

CREATE TABLE students (
	studentId BIGINT AUTO_INCREMENT NOT NULL,
	firstName VARCHAR(255),
	lastName VARCHAR(255),
	PRIMARY KEY(studentId)
);

## just for fun, let's make all the studentId values start
## at a predfined number (rather than getting the default
## starting value of 1 for an AUTO_INCREMENT column)
ALTER TABLE students AUTO_INCREMENT = 1000;

CREATE TABLE classes (
	classId INT AUTO_INCREMENT NOT NULL,
	semester VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	location VARCHAR(255) NOT NULL,
	PRIMARY KEY(classId)
);

CREATE TABLE enrollment (
	studentId BIGINT NOT NULL,
	classId INT NOT NULL,
	enrollmentDate DATE NOT NULL,
	dropDate DATE,
	PRIMARY KEY(studentId, classId)	
);


## create the first class and capture the assigned
## ID in a variable so we can use it later
INSERT INTO classes VALUES (NULL, "Spring 2022", "CSC106 - Object Oriented Programming", "LTOW Lower Lab");
SET @csc106Id := LAST_INSERT_ID(); ## capture the assigned value

## create the next class and capture the assigned
## ID in a variable so we can use it later
INSERT INTO classes VALUES (NULL, "Spring 2022", "CSC212 - Database Systems", "LTOW Lower Lab");
SET @csc212Id := LAST_INSERT_ID(); ## capture the assigned value


## create the first student and enroll them in both classes
INSERT INTO students VALUES (NULL, "John", "Doe");
SET @studentId := LAST_INSERT_ID();

INSERT INTO enrollment VALUES (@studentId, @csc106Id, CURRENT_DATE, NULL);
INSERT INTO enrollment VALUES (@studentId, @csc212Id, CURRENT_DATE, NULL);


## create the next student and enroll them in both classes
INSERT INTO students VALUES (NULL, "Jane", "Doe");
SET @studentId := LAST_INSERT_ID();

INSERT INTO enrollment VALUES (@studentId, @csc106Id, CURRENT_DATE, NULL);
INSERT INTO enrollment VALUES (@studentId, @csc212Id, CURRENT_DATE, NULL);

