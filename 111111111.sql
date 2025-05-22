create database Lennujaam
use Lennujaam;

CREATE TABLE töötaja (
  tööID INT PRIMARY KEY,
  nimi VARCHAR(50),
  elukutse VARCHAR(50)
);

CREATE TABLE lennujaam (
  jaamID INT PRIMARY KEY,
  linn VARCHAR(50),
  aadress VARCHAR(50),
  jaama_nimi VARCHAR(50)
);

CREATE TABLE lennufirma (
  firmaID INT PRIMARY KEY,
  firmanimi VARCHAR(50),
  konrakt_info VARCHAR(50)
);

CREATE TABLE lennuk (
  lennukID INT PRIMARY KEY,
  muudel VARCHAR(50),
  firmaID INT,
  FOREIGN KEY (firmaID) REFERENCES lennufirma(firmaID)
);

CREATE TABLE ettevõtti (
  etteID INT PRIMARY KEY,
  ettenimi VARCHAR(50),
  jaamID INT,
  kirjeldus VARCHAR(50),
  FOREIGN KEY (jaamID) REFERENCES lennujaam(jaamID)
);

CREATE TABLE pood (
  poodID INT PRIMARY KEY,
  poe_nimi VARCHAR(50),
  jaamID INT,
  FOREIGN KEY (jaamID) REFERENCES lennujaam(jaamID)
);

CREATE TABLE tööplaan (
  tööplaanID INT PRIMARY KEY,
  tööID INT,
  jaamID INT,
  kuupäev VARCHAR(50),
  FOREIGN KEY (tööID) REFERENCES töötaja(tööID),
  FOREIGN KEY (jaamID) REFERENCES lennujaam(jaamID)
);


INSERT INTO töötaja (tööID, nimi, elukutse) VALUES
(1, 'Mari Tamm', 'Turvatöötaja'),
(2, 'Jaan Kask', 'Piletimüüja'),
(3, 'Tiina Saar', 'Pagasikäitleja');

INSERT INTO lennujaam (jaamID, linn, aadress, jaama_nimi) VALUES
(1, 'Tallinn', 'Lennujaama tee 12', 'Tallinna Lennujaam'),
(2, 'Tartu', 'Turu 8', 'Tartu Lennujaam');

INSERT INTO lennufirma (firmaID, firmanimi, konrakt_info) VALUES
(1, 'Air Estonia', 'kontakt@airestonia.ee'),
(2, 'NordSky', 'info@nordsky.ee');

INSERT INTO lennuk (lennukID, muudel, firmaID) VALUES
(1, 'Boeing 737', 1),
(2, 'Airbus A320', 2);

INSERT INTO ettevõtti (etteID, ettenimi, jaamID, kirjeldus) VALUES
(1, 'CleanAir OÜ', 1, 'Puhastusteenused'),
(2, 'FoodExpress AS', 2, 'Toiduteenindus');

INSERT INTO pood (poodID, poe_nimi, jaamID) VALUES
(1, 'Reisikohver', 1),
(2, 'Kohvik Päike', 2);

INSERT INTO tööplaan (tööplaanID, tööID, jaamID, kuupäev) VALUES
(1, 1, 1, '2025-06-01'),
(2, 2, 1, '2025-06-01'),
(3, 3, 2, '2025-06-02');

--kõik tabelite inner join'nid create view
CREATE VIEW Vaade_Tööplaan_Täielik AS
SELECT 
    tp.tööplaanID,
    tp.kuupäev,
    t.nimi AS töötaja_nimi,
    t.elukutse,
    lj.jaama_nimi,
    lj.linn,
    lf.firmanimi,
    l.muudel AS lennuki_muudel,
    et.ettenimi AS ettevõte,
    et.kirjeldus AS ettevõtte_kirjeldus,
    p.poe_nimi AS pood_nimi
FROM tööplaan tp
INNER JOIN töötaja t ON tp.tööID = t.tööID
INNER JOIN lennujaam lj ON tp.jaamID = lj.jaamID
LEFT JOIN ettevõtti et ON lj.jaamID = et.jaamID
LEFT JOIN pood p ON lj.jaamID = p.jaamID
LEFT JOIN lennuk l ON l.firmaID IN (
    SELECT firmaID FROM lennufirma
)
LEFT JOIN lennufirma lf ON l.firmaID = lf.firmaID;

select * from töötaja
select * from lennujaam
select * from ettevõtti
select * from pood
select * from lennuk
select * from lennufirma
select * from tööplaan

--lennuk ja lennufirma inner join create view
CREATE VIEW Vaade_Lennukid_Firmad AS
SELECT 
    l.lennukID,
    l.muudel AS lennuki_mudel,
    lf.firmanimi AS lennufirma
FROM lennuk l
INNER JOIN lennufirma lf ON l.firmaID = lf.firmaID;

--pood ja lennujaam inner join create view
CREATE VIEW Vaade_Poed_Lennujaamad AS
SELECT 
    p.poodID,
    p.poe_nimi,
    lj.jaama_nimi,
    lj.linn
FROM pood p
INNER JOIN lennujaam lj ON p.jaamID = lj.jaamID;

SELECT * FROM Vaade_Tööplaan_Täielik;
SELECT * FROM Vaade_Lennukid_Firmad;
SELECT * FROM Vaade_Poed_Lennujaamad;


--procseduurit
CREATE PROCEDURE LisaUusTöötaja
    @tööID INT,
    @nimi VARCHAR(50),
    @elukutse VARCHAR(50)
AS
BEGIN
    INSERT INTO töötaja (tööID, nimi, elukutse)
    VALUES (@tööID, @nimi, @elukutse);
END;

--exec
EXEC LisaUusTöötaja @tööID = 4, @nimi = 'Karl Kuusk', @elukutse = 'Turvajuht';

CREATE PROCEDURE TöötajaTööplaan
    @tööID INT
AS
BEGIN
    SELECT * FROM tööplaan
    WHERE tööID = @tööID;
END;

--exec
EXEC TöötajaTööplaan @tööID = 1;


CREATE PROCEDURE LisaLennuk
    @lennukID INT,
    @muudel VARCHAR(50),
    @firmaID INT
AS
BEGIN
    INSERT INTO lennuk (lennukID, muudel, firmaID)
    VALUES (@lennukID, @muudel, @firmaID);
END;

--exec
EXEC LisaLennuk @lennukID = 3, @muudel = 'Embraer 190', @firmaID = 2;


CREATE PROCEDURE LennujaamaDetailid
    @jaamID INT
AS
BEGIN
    SELECT * FROM lennujaam WHERE jaamID = @jaamID;

    SELECT * FROM pood WHERE jaamID = @jaamID;

    SELECT * FROM ettevõtti WHERE jaamID = @jaamID;

    SELECT * FROM tööplaan WHERE jaamID = @jaamID;
END;

--exec
EXEC LennujaamaDetailid @jaamID = 1;


CREATE PROCEDURE MuudaFirmaKontakt
    @firmaID INT,
    @uusKontakt VARCHAR(50)
AS
BEGIN
    UPDATE lennufirma
    SET konrakt_info = @uusKontakt
    WHERE firmaID = @firmaID;
END;

--exec
EXEC MuudaFirmaKontakt @firmaID = 1, @uusKontakt = 'kontakt@uuendus.ee';
