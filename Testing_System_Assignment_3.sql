-- Assignment3
USE simpledb;
-- câu 2 lấy ra tất cả các phòng ban
SELECT * FROM department;

-- Câu 3 lấy ra id của phòng ban "Sale"
SELECT * FROM department WHERE DepartmentName = 'Sale';

-- Câu 4: lấy ra thông tin account có full name dài nhất
SELECT *
FROM `Account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`);

-- Câu 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3
SELECT * FROM `Account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account` WHERE departmentID =3 ) AND departmentID =3;

-- câu 6 Lấy ra tên group đã tạo trước ngày TỰ CHỌN
SELECT * FROM `group`
WHERE DATE(CreateDate) < '2020-03-09';

-- câu 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT * FROM answer;
SELECT QuestionID FROM answer
GROUP BY QuestionID
HAVING SL >=4;

-- CÂU 8 Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày TỰ CHỌN
SELECT * FROM exam
WHERE Duration >=60 AND CreateDate > '2020-04-7 00:00:00';

-- CÂU 9 Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `group`
ORDER BY CreateDate DESC
LIMIT 5;

-- CÂU 10 Đếm số nhân viên thuộc department có id = 2
SELECT departmentID, COUNT(AccountID) AS SL
FROM `Account`
WHERE DepartmentID = 2;

-- CÂU 11 Lấy ra nhân viên có tên bắt đầu bằng chữ "F" và kết thúc bằng "1"
SELECT Fullname
FROM `Account`
WHERE (SUBSTRING_INDEX(FullName, ' ', -1)) LIKE 'F%1' ;

-- CÂU 12 Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM Exam
WHERE CreateDate < '2019-12-20';

-- CÂU 13 Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE
FROM `question`
WHERE Content LIKE ('C%');

-- CÂU 14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET Fullname = N'Nguyễn Bá Lộc',
Email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;

-- CÂU 15 update account có id = 5 sẽ thuộc group có id = 4
UPDATE `GroupAccount` 
SET GroupID = 4
WHERE  AccountID = 5;