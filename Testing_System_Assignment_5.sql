-- Exercise 1: Tiếp tục với Database Testing System (Sử dụng subquery hoặc CTE)
USE simpledb;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Sử dụng VIEW
CREATE OR REPLACE VIEW vw_DSNV_Sale AS
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';
SELECT * FROM vw_DSNV_Sale;
-- Sử dụng CTE
WITH DSNV_Sale AS(
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale'
)
SELECT *
FROM DSNV_Sale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW vw_GetAccount AS
WITH CTE_GetListCountAccount AS(
SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID
)
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM CTE_GetListCountAccount
);
SELECT * FROM vw_GetAccount;
-- Trong mục đáp án VTI câu lệnh đang sử dụng lệnh Limit để lấy giới hạn 1 tuy nhiên cách
-- làm này trong th này vẫn tối ưu được dữ liệu, do số lượng này sẽ trùng nhau trong các TH.
-- Viết bằng CTE, cách này viết nguyên cả câu lệnh bằng CTE, tuy nhiên cách này không tối
-- ưu, CTE sinh ra không phải cho TH này
WITH CTE_DSNV_Sale AS(
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM
(SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID) AS tableGA1
))

SELECT * FROM vw_DSNV_Sale;
-- Viết bằng CTE, chia câu lệnh mySQL thành các câu lệnh nhỏ hơn để thực thi:
WITH CTE_DSNV_Sale AS(
SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID
)
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM CTE_DSNV_Sale
);
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW vw_ContenTren18Tu
AS
SELECT *
FROM Question
WHERE LENGTH(Content) > 18;
SELECT *
FROM vw_ContenTren18Tu;
-- Thực hiện xóa
DELETE FROM vw_ContenTren18Tu;
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW vw_MaxNV
AS
SELECT D.DepartmentName, count(A.DepartmentID) AS SL
FROM account A
INNER JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT MAX(countDEP_ID) AS maxDEP_ID FROM
(SELECT count(A1.DepartmentID) AS countDEP_ID FROM account A1
GROUP BY A1.DepartmentID) AS TB_countDepID);
SELECT * FROM vw_MaxNV;
-- Sử dụng CTE:
CREATE OR REPLACE VIEW vw_MaxNV AS
WITH CTE_Count_NV AS(
SELECT count(A1.DepartmentID) AS countDEP_ID FROM account A1
GROUP BY A1.DepartmentID)
SELECT D.DepartmentName, count(A.DepartmentID) AS SL
FROM account A
INNER JOIN `department` D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT max(countDEP_ID) FROM CTE_Count_NV);
SELECT * FROM vw_MaxNV;
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW vw_Que5
AS
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn';
SELECT * FROM vw_Que5;
-- Sử dụng CTE:
WITH cte_Que5 AS(
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn'
)
SELECT * FROM cte_Que5;