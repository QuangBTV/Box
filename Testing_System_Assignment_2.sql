CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        DepartmentName NVARCHAR(30) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        PositionName ENUM ('DEV', 'TEST', 'SCRUM MASTER', 'PM') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS  `Account`;
CREATE TABLE `Account` (
	AccountID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        Email VARCHAR(50) NOT NULL UNIQUE KEY,
        Username VARCHAR(50) NOT NULL UNIQUE KEY,
        FullName VARCHAR(50) NOT NULL,
        DepartmentID TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
        PositionID TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID),
        CreateDate DATE
);
DROP TABLE IF EXISTS  `Group`;
CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID TINYINT UNSIGNED,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS  GroupAccount;
CREATE TABLE GroupAccount(
    GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY(GroupID,AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS  TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        TypeName ENUM ('ESSAY','MULTIPLE-CHOICE') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS  CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        Content NVARCHAR(100) NOT NULL,
        CategoryID TINYINT UNSIGNED NOT NULL,
        TypeID TINYINT UNSIGNED NOT NULL,
        CreatorID TINYINT UNSIGNED NOT NULL,
        CreateDate DATETIME DEFAULT NOW(),
        FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
        FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
        FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
		AnswerID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        Content NVARCHAR(200) NOT NULL,
        QuestionID TINYINT UNSIGNED NOT NULL,
        isCorrect BIT(1),
        FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `Code` CHAR(10) NOT NULL,
        Title NVARCHAR(100) NOT NULL,
        CategoryID TINYINT UNSIGNED NOT NULL,
        Duration TINYINT UNSIGNED NOT NULL,
        CreatorID TINYINT UNSIGNED NOT NULL,
        CreateDate DATETIME DEFAULT NOW(),
        FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
        FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID TINYINT UNSIGNED NOT NULL,
        QuestionID TINYINT UNSIGNED NOT NULL,
        FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
        FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
        PRIMARY KEY (ExamID,QuestionID)
);

INSERT INTO Department(DepartmentName)
VALUES
(N'Marketing' ),
(N'Sale' ),
(N'Bảo vệ' ),
(N'Nhân sự' ),
(N'Kỹ thuật' ),
(N'Tài chính' ),
(N'Phó giám đốc'),
(N'Giám đốc' ),
(N'Thư kí' ),
(N'No person' ),
(N'Bán hàng' );
INSERT INTO Position (PositionName )
VALUES ('Dev' ),
('Test' ),
('Scrum Master'),
('PM' );
INSERT INTO `Account`(Email , Username
, FullName , DepartmentID , PositionID,
CreateDate)
VALUES ('Email1@gmail.com' ,
'Username1' ,'Fullname1' , '5' , '1'
,'2023-06-30'),
('Email2@gmail.com' ,
'Username2' ,'Fullname2' , '1' , '2'
,'2023-07-01'),('Email3@gmail.com' , 'Username3' ,'Fullname3'
, '2' , '2' ,'2023-07-01'),
('Email4@gmail.com' , 'Username4' ,'Fullname4'
, '3' , '4' ,'2023-07-02'),
('Email5@gmail.com' , 'Username5' ,'Fullname5'
, '4' , '4' ,'2023-07-03'),
('Email6@gmail.com' , 'Username6' ,'Fullname6'
, '6' , '3' ,'2023-07-01'),
('Email7@gmail.com' , 'Username7' ,'Fullname7'
, '2' , '2' , '2023-07-01' ),
('Email8@gmail.com' , 'Username8' ,'Fullname8'
, '8' , '1' ,'2023-07-02'),
('Email9@gmail.com' , 'Username9' ,'Fullname9'
, '2' , '2' ,'2023-07-01'),
('Email10@gmail.com' , 'Username10' ,'Fullname10'
, '10' , '1' ,'2023-07-01');
INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES (N'Marketing A' , 3
,'2023-05-06'),
(N'Development B' , 1
,'2023-03-07'),
(N'Sale 01' , 2 ,'2023-06-20'),
(N'Sale 02' , 5 ,'2023-06-21'),
(N'Relax' , 4 ,'2023-06-28'),
(N'Meeting' , 6 ,'2023-06-06'),
(N'Training' , 7 ,'2023-06-07'),
(N'Management' , 8 ,'2023-06-08'),
(N'Testing' , 9 ,'2023-06-09'),
(N'Canteen' , 10 ,'2023-06-10');

INSERT INTO GroupAccount ( GroupID , AccountID , JoinDate )
VALUES ( 1 , 1,'2023-06-05'),
( 1 , 2,'2023-06-07'),
( 3 , 3,'2023-06-09'),
( 3 , 4,'2023-06-10'),
( 5 , 5,'2023-06-28'),
( 1 , 3,'2023-06-06'),
( 1 , 7,'2023-06-07'),
( 8 , 3,'2023-06-08'),
( 1 , 9,'2023-06-09'),
( 10 , 10,'2023-06-10');
INSERT INTO TypeQuestion (TypeName )
VALUES 
('Essay' ),
('Multiple-Choice' );
INSERT INTO CategoryQuestion (CategoryName )
VALUES 
('Java' ),
('ASP.NET' ),
('ADO.NET' ),
('SQL' ),
('Postman' ),
('Ruby' ),
('Python' ),
('C++' ),
('C Sharp' ),
('PHP' );
INSERT INTO Question (Content , CategoryID, TypeID , CreatorID
, CreateDate )
VALUES 
(N'Câu hỏi Java' , 1 ,'1' , '2' ,'2023-06-05'),
(N'Câu hỏi PHP' , 7 ,'2' , '2' ,'2023-06-05'),
(N'Câu hỏi C#' , 9 ,'2' , '3' ,'2023-06-06'),
(N'Câu hỏi Ruby' , 6 ,'1' , '4' ,'2023-06-06'),
(N'Câu hỏi Postman' , 5 ,'1' , '5' ,'2023-06-06'),
(N'Câu hỏi ADO.NET' , 3 ,'2' , '6' ,'2023-06-06'),
(N'Câu hỏi ASP.NET' , 2 ,'1' , '7' ,'2023-06-06'),
(N'Câu hỏi C++' , 8 ,'1' , '8' ,'2023-06-07'),
(N'Câu hỏi SQL' , 4 ,'2' , '9' ,'2023-06-07'),
(N'Câu hỏi Python' , 10 ,'1' , '10' ,'2023-06-07');

INSERT INTO Answer ( Content , QuestionID , isCorrect )
VALUES 
(N'Trả lời 01' , 1 , 0),
(N'Trả lời 02' , 1 , 1),
(N'Trả lời 03', 1 , 0 ),
(N'Trả lời 04', 1 , 1 ),
(N'Trả lời 05', 2 , 1 ),
(N'Trả lời 06', 3 , 1 ),
(N'Trả lời 07', 4 , 0 ),
(N'Trả lời 08', 8 , 0 ),
(N'Trả lời 09', 9 , 1 ),
(N'Trả lời 10', 10 , 1 );

INSERT INTO Exam (`Code` , Title , CategoryID, Duration , CreatorID , CreateDate )
VALUES
('CODE001' , N'Đề thi C#' ,1 , 60 , '5' ,'2023-04-05'),
('CODE002' , N'Đề thi PHP' ,10 , 60 , '2' ,'2023-04-05'),
('CODE003' , N'Đề thi C++' , 9 ,120 , '2' ,'2023-04-07'),
('CODE004' , N'Đề thi Java' , 6 , 60, '3' ,'2023-04-08'),
('CODE005' , N'Đề thi Ruby' , 5 , 120, '4' ,'2023-04-10'),
('CODE006' , N'Đề thi Postman' , 3 ,60 , '6' ,'2023-04-05'),
('CODE007' , N'Đề thi SQL' , 2 ,60 , '7' ,'2023-04-05'),
('CODE008' , N'Đề thi Python' , 8 ,60 , '8' ,'2023-04-07'),
('CODE009' , N'Đề thi ADO.NET' , 4 ,90 , '9' ,'2023-04-07'),
('CODE010' , N'Đề thi ASP.NET' , 7 ,90 , '10' ,'2023-04-08');

INSERT INTO ExamQuestion(ExamID , QuestionID )
VALUES 
( 1 , 5 ),
( 2 , 10 ),
( 3 , 4 ),
( 4 , 3 ),
( 5 , 7 ),
( 6 , 10 ),
( 7 , 2 ),
( 8 , 10 ),
( 9 , 9 ),
( 10 , 8 );
