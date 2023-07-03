CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;
CREATE TABLE Department (
		DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
        DepartmentName VARCHAR(30)
);
CREATE TABLE Position (
		PositionID INT PRIMARY KEY AUTO_INCREMENT,
        PositionName VARCHAR(30)
);
CREATE TABLE Account (
		AccountID INT PRIMARY KEY AUTO_INCREMENT,
        Email VARCHAR(30),
        Username VARCHAR(20),
        FullName VARCHAR(30),
        DepartmentID INT,
        PositionID INT,
        CreateDate DATE
);
CREATE TABLE Group1(
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(30),
    CreatorID INT,
    CreateDate DATE
);
CREATE TABLE GroupAccount(
	GroupID INT,
    AccountID INT,
    JoinDate DATE
);
CREATE TABLE TypeQuestion(
		TypeID INT PRIMARY KEY AUTO_INCREMENT,
        TypeName VARCHAR(20)
);
CREATE TABLE CategoryQuestion(
		CategoryID INT PRIMARY KEY AUTO_INCREMENT,
        CategoryName VARCHAR(20)
);
CREATE TABLE Question(
		QuestionID INT PRIMARY KEY AUTO_INCREMENT,
        Content NVARCHAR(500),
        CategoryID INT,
        TypeID INT,
        CreatorID INT,
        CreateDate DATE
);
CREATE TABLE Answer (
		AnswerID INT PRIMARY KEY AUTO_INCREMENT,
        Content NVARCHAR(1000),
        QuestionID INT,
        isCorrect BOOLEAN
);

CREATE TABLE Exam(
		ExamID INT PRIMARY KEY AUTO_INCREMENT,
        Code_exam INT,
        Title NVARCHAR(50),
        CategoryID INT,
        Duration INT,
        CreatorID INT,
        CreateDate DATE
);
CREATE TABLE ExamQuestion(
		ExamID INT,
        QuestionID INT
);