-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-05-09 06:44:42.826

create database Normaliseerimine
use Normaliseerimine;

-- tables
-- Table: Aine
CREATE TABLE Aine (
    AineID int  NOT NULL,
    Aine varchar(30)  NOT NULL,
    CONSTRAINT Aine_pk PRIMARY KEY  (AineID)
);

-- Table: AineOpitaja
CREATE TABLE AineOpitaja (
    AineOpetajaID int  NOT NULL,
    Teacher_TeacherID int  NOT NULL,
    Aine_AineID int  NOT NULL,
    CONSTRAINT AineOpitaja_pk PRIMARY KEY  (AineOpetajaID)
);

-- Table: Hind
CREATE TABLE Hind (
    HindID int  NOT NULL,
    Hind varchar(30)  NOT NULL,
    CONSTRAINT Hind_pk PRIMARY KEY  (HindID)
);

-- Table: Result
CREATE TABLE Result (
    DokumentiNumber int  NOT NULL,
    Student_StudentID int  NOT NULL,
    AineOpitaja_AineOpetajaID int  NOT NULL,
    TooTyyp_TooID int  NOT NULL,
    Hind_HindID int  NOT NULL,
    CONSTRAINT Result_pk PRIMARY KEY  (DokumentiNumber)
);

-- Table: Student
CREATE TABLE Student (
    StudentID int  NOT NULL,
    SecondName varchar(50)  NOT NULL,
    Keskmine varchar(20)  NOT NULL,
    "Group" varchar(20)  NOT NULL,
    Fakultet varchar(50)  NOT NULL,
    Semestr int  NOT NULL,
    CONSTRAINT Student_pk PRIMARY KEY  (StudentID)
);

-- Table: Teacher
CREATE TABLE Teacher (
    TeacherID int  NOT NULL,
    Teacher varchar(30)  NOT NULL,
    CONSTRAINT Teacher_pk PRIMARY KEY  (TeacherID)
);

-- Table: TooTyyp
CREATE TABLE TooTyyp (
    TooID int  NOT NULL,
    TooTyyp varchar(30)  NOT NULL,
    CONSTRAINT TooTyyp_pk PRIMARY KEY  (TooID)
);

-- foreign keys
-- Reference: AineOpitaja_Aine (table: AineOpitaja)
ALTER TABLE AineOpitaja ADD CONSTRAINT AineOpitaja_Aine
    FOREIGN KEY (Aine_AineID)
    REFERENCES Aine (AineID);

-- Reference: AineOpitaja_Teacher (table: AineOpitaja)
ALTER TABLE AineOpitaja ADD CONSTRAINT AineOpitaja_Teacher
    FOREIGN KEY (Teacher_TeacherID)
    REFERENCES Teacher (TeacherID);

-- Reference: Result_AineOpitaja (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_AineOpitaja
    FOREIGN KEY (AineOpitaja_AineOpetajaID)
    REFERENCES AineOpitaja (AineOpetajaID);

-- Reference: Result_Hind (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_Hind
    FOREIGN KEY (Hind_HindID)
    REFERENCES Hind (HindID);

-- Reference: Result_Student (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_Student
    FOREIGN KEY (Student_StudentID)
    REFERENCES Student (StudentID);

-- Reference: Result_TooTyyp (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_TooTyyp
    FOREIGN KEY (TooTyyp_TooID)
    REFERENCES TooTyyp (TooID);



-- Aine (Õppeained)
INSERT INTO Aine (AineID, Aine) VALUES
(1, 'Keemia'),
(2, 'Füüsika'),
(3, 'Ajalugu');

-- Õpetajad
INSERT INTO Teacher (TeacherID, Teacher) VALUES
(1, 'Petrov'),
(2, 'L’vov'),
(3, 'Somov');

-- Töö tüüp (nt. eksam)
INSERT INTO TooTyyp (TooID, TooTyyp) VALUES
(1, 'Eksam');

-- Hinded
INSERT INTO Hind (HindID, Hind) VALUES
(1, 'Suurepärane'),
(2, 'Hea'),
(3, 'Rahuldav');

-- Õpilased
INSERT INTO Student (StudentID, SecondName, Keskmine, "Group", Fakultet, Semestr) VALUES
(1, 'Panov', 'Suurepärane', 'G1', 'F1', 1),
(2, 'Turov', 'Hea', 'G2', 'F1', 1),
(3, 'Serov', 'Hea', 'G3', 'F2', 1);

-- Õppeaine ja õpetaja seos
INSERT INTO AineOpitaja (AineOpetajaID, Teacher_TeacherID, Aine_AineID) VALUES
(1, 3, 1),
(2, 1, 2),
(3, 2, 3);

-- Tulemus
INSERT INTO Result (DokumentiNumber, Student_StudentID, AineOpitaja_AineOpetajaID, TooTyyp_TooID, Hind_HindID) VALUES
(1, 1, 1, 1, 1),
(2, 1, 2, 1, 1),
(3, 1, 3, 1, 1),
(4, 2, 1, 1, 2),
(5, 2, 2, 1, 1),
(6, 2, 3, 1, 2),
(7, 3, 1, 1, 1),
(8, 3, 2, 1, 1),
(9, 3, 3, 1, 3);




SELECT 
R.DokumentiNumber, S.SecondName AS StudentName, S."Group", S.Fakultet, A.Aine AS Subject, T.Teacher AS TeacherName, TT.TooTyyp AS WorkType, H.Hind AS Grade
FROM Result R
INNER JOIN Student S ON R.Student_StudentID = S.StudentID
INNER JOIN AineOpitaja AO ON R.AineOpitaja_AineOpetajaID = AO.AineOpetajaID
INNER JOIN Teacher T ON AO.Teacher_TeacherID = T.TeacherID
INNER JOIN Aine A ON AO.Aine_AineID = A.AineID
INNER JOIN TooTyyp TT ON R.TooTyyp_TooID = TT.TooID
INNER JOIN Hind H ON R.Hind_HindID = H.HindID;

CREATE PROCEDURE AddAine
    @AineID INT,
    @Aine VARCHAR(30)
AS
BEGIN
    INSERT INTO Aine (AineID, Aine)
    VALUES (@AineID, @Aine);
END;

EXEC AddAine 4, 'Bioloogia';

select * from Aine


CREATE PROCEDURE GetTeacherSubjects
    @TeacherID INT
AS
BEGIN
SELECT A.Aine
FROM AineOpitaja AO
JOIN Aine A ON AO.Aine_AineID = A.AineID
WHERE AO.Teacher_TeacherID = @TeacherID;
END;

EXEC GetTeacherSubjects 2;

select * from Teacher;

DROP TABLE Result;
DROP TABLE AineOpitaja;
DROP TABLE Student;
DROP TABLE Teacher;
DROP TABLE Aine;
DROP TABLE Hind;
DROP TABLE TooTyyp;





-- End of file.

