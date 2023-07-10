CREATE DATABASE Extra_Assignment_4;
USE Extra_Assignment_4;

-- Ex 1: 
-- Q1: Create Table 
-- Department (Department_Number, Department_Name)
-- Employee_Table (Employee_Number, Employee_Name, Department_Number)
-- Employee_Skill_Table (Employee_Number, Skill_Code, Date Registered)

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	Department_Number 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Department_Name		NVARCHAR(50) UNIQUE KEY NOT NULL
);
DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE Employee_Table(
	Employee_Number 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Employee_Name		NVARCHAR(50) NOT NULL,
    Department_Number	TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(Department_Number) REFERENCES Department(Department_Number)
);
DROP TABLE IF EXISTS Employee_Skill_Table;
CREATE TABLE Employee_Skill_Table(
	Employee_Number 	TINYINT UNSIGNED AUTO_INCREMENT,
    Skill_Code			NVARCHAR(20) NOT NULL,
    Date_Registered		DATETIME DEFAULT NOW(),
    FOREIGN KEY(Employee_Number) REFERENCES Employee_Table(Employee_Number)
);

-- 2: Add at least 10 records into created table

INSERT INTO Department	(Department_Name) 
VALUE 					(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);

INSERT INTO Employee_Table 	(Employee_Name, Department_Number)
VALUE						(N'Nguyễn Văn A'	,		1			),
							(N'Nguyễn Văn B'	,		2			),
                            (N'Nguyễn Văn C'	,		3			),
                            (N'Nguyễn Văn D'	,		5			),
                            (N'Nguyễn Văn E'	,		6			),
                            (N'Nguyễn Văn F'	,		4			),
                            (N'Nguyễn Văn G'	,		5			),
                            (N'Nguyễn Văn H'	,		3			),
                            (N'Tên thứ Chín'	,		9			),
                            (N'Ông Mười'	,		10				); 
                            
INSERT INTO Employee_Skill_Table (Employee_Number, Skill_Code, Date_Registered)
VALUE
( 	1,		'Java'		, '2023-06-15'	),
( 	2,		'Android'	, '2023-06-16'	),
( 	3,		'C#'		, '2023-06-17'	),
( 	4,		'SQL'		, '2023-06-20'	),
( 	3,		'ASP.NET'	, '2023-06-21'	),
( 	2,		'Python'	, '2023-06-22'	),
( 	1,		'JS'		, '2023-06-24'	),
( 	6,		'C++'		, '2023-06-27'	),
( 	7,		'C Sharp'	, '2023-06-04'	),
( 	10,		'PHP'		, '2023-06-10'	);  

 -- Question 3: Query all Employee (include: name) who has Java skill.
SELECT 	ET.Employee_Number, ET.Employee_Name, ET.Department_Number, EST.Skill_Code 
FROM	Employee_Table ET
INNER JOIN Employee_Skill_Table EST
ON		ET.Employee_Number = EST.Employee_Number
WHERE	EST.Skill_Code = 'Java';

-- Question 4: Query all department which has more than 3 employee
SELECT		D.Department_Number, D.Department_Name, COUNT(ET.Department_Number)
FROM		Department D INNER JOIN Employee_Table ET
ON			D.Department_Number = ET.Department_Number
GROUP BY 	ET.Department_Number
HAVING		COUNT(ET.Department_Number)>=3
ORDER BY	D.Department_Number ASC;

-- Question 5: Query all employee of each department.
SELECT		ET.*
FROM		Department D INNER JOIN Employee_Table ET
ON			D.Department_Number = ET.Department_Number
ORDER BY	D.Department_Number ASC;

-- Question 6: Query all Employee (include: name) who has more than 1 skills.
SELECT 		ET.*, COUNT(1) as TotalSkills
FROM		Employee_Table ET RIGHT JOIN Employee_Skill_Table EST
ON			ET.Employee_Number = EST.Employee_Number
GROUP BY	ET.Employee_Number
HAVING 		TotalSkills >1;                        