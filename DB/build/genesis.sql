/* Javier Sorribes, 04/04/2017
	Schema for DB
	Based on HW 1, CS 425
*/

CREATE DATABASE IF NOT EXISTS library;
USE library;

CREATE TABLE users
(
  username VARCHAR(20) NOT NULL,
  userpass VARCHAR(20) NOT NULL,
  role INT NOT NULL,
  PRIMARY KEY (username)
);

CREATE TABLE admin
(
  username VARCHAR(20) NOT NULL,
  adminid INT NOT NULL AUTO_INCREMENT,
  lastname VARCHAR(20) NOT NULL, -- Added name for Admin and Teacher
  firstname VARCHAR(20) NOT NULL,
  PRIMARY KEY (adminid),
  FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE teacher
(
  username VARCHAR(20) NOT NULL,
  teacherid INT NOT NULL AUTO_INCREMENT,
  lastname VARCHAR(20) NOT NULL,
  firstname VARCHAR(20) NOT NULL,
  PRIMARY KEY (teacherid),
  FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE student
(
  username VARCHAR(20) NOT NULL,
  studentid INT NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(20) NOT NULL,
  lastname VARCHAR(20) NOT NULL,
  amountdue NUMERIC,
  advisorid INT NOT NULL,
  PRIMARY KEY (studentid),
  FOREIGN KEY (advisorid) REFERENCES teacher(teacherid),
  FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE parent
(
  /*studentid INT NOT NULL,*/
  lastname VARCHAR(20) NOT NULL,
  firstname VARCHAR(20) NOT NULL,
  PRIMARY KEY (lastname, firstname)
  /*FOREIGN KEY (studentid) REFERENCES student(studentid)*/
);

CREATE TABLE parent_contact
(
  /*studentid INT NOT NULL,*/
  contact VARCHAR(50) NOT NULL,
  lastname VARCHAR(20) NOT NULL,
  firstname VARCHAR(20) NOT NULL,
  PRIMARY KEY (contact, lastname, firstname),
  FOREIGN KEY (lastname, firstname) REFERENCES parent(lastname, firstname)
);

CREATE TABLE course
(
  name VARCHAR(20) NOT NULL,
  year INT(4) NOT NULL,
  semester ENUM('fall','spring','summer') NOT NULL,
  teacherid INT NOT NULL,
  PRIMARY KEY (name, year, semester),
  FOREIGN KEY (teacherid) REFERENCES teacher(teacherid)
);

CREATE TABLE book
(
  bookid INT NOT NULL AUTO_INCREMENT,
  isbn INT NOT NULL,
  cost NUMERIC(6,2) NOT NULL,
  duedate DATE,
  datecheckedout DATE,
  orderbytype VARCHAR(20),
  title VARCHAR(50) NOT NULL,
  coursename VARCHAR(20) NOT NULL,
  courseyear INT(4) NOT NULL,
  coursesemester ENUM('fall','spring','summer') NOT NULL,
  studentid INT,
  PRIMARY KEY (bookid),
  FOREIGN KEY (coursename, courseyear, coursesemester) REFERENCES course(name, year, semester),
  FOREIGN KEY (studentid) REFERENCES student(studentid)
);

-- M:N relationships
CREATE TABLE has
(
  studentid INT NOT NULL,
  lastname VARCHAR(20) NOT NULL,
  firstname VARCHAR(20) NOT NULL,
  PRIMARY KEY (studentid, lastname, firstname),
  FOREIGN KEY (studentid) REFERENCES student(studentid),
  FOREIGN KEY (lastname, firstname) REFERENCES parent(lastname, firstname)
);

CREATE TABLE takes
(
  studentid INT NOT NULL,
  name VARCHAR(20) NOT NULL,
  year INT NOT NULL,
  semester ENUM('fall','spring','summer') NOT NULL,
  PRIMARY KEY (studentid, name, year, semester),
  FOREIGN KEY (studentid) REFERENCES student(studentid),
  FOREIGN KEY (name, year, semester) REFERENCES course(name, year, semester)
);

CREATE TABLE controls
(
  adminid INT NOT NULL,
  bookid INT NOT NULL,
  /*name VARCHAR(20) NOT NULL,
  year INT NOT NULL,
  semester CHAR NOT NULL,*/
  PRIMARY KEY (adminid, bookid),/*, name, year, semester),*/
  FOREIGN KEY (adminid) REFERENCES admin(adminid),
  FOREIGN KEY (bookid) REFERENCES book(bookid)
);
