create database bth1_2_3QLSV;
USE bth1_2_3QLSV;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Statuss    BIT
); 
insert into class
values(1,'LOP 12A7','2019-09-02',1),
(2,'LOP 12A1','2018-05-12',1);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Statuss      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
insert into student
values(1,'Nguyen V','Thanh Hoa','09765643222',1,1),
(2,'Nguyen L','Thanh Hoa','09765643422',0,2),
(3,'Nguyen c','Ha Noi','097652333222',1,1);
CREATE TABLE Subjects
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Statuss  BIT                  DEFAULT 1
);
insert into subjects
values(1,'Mon Van',1,1),
(2,'Mon Toan',2,1),
(3,'Mon Anh',2,1);
CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subjects (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);
SELECT st.Address, COUNT(st.StudentId) AS 'Số lượng học viên'
FROM Student st
GROUP BY st.Address;

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S
         join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 15;

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);