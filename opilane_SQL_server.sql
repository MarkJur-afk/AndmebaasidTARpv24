--AB loomine 
create database JurgenTARpv24Baas;

use JurgenTARpv24Baas;
create table opilane(
opilaneId int primary key identity(1,1), 
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
aadres text,
stip bit,
keskmine_hinne decimal(2, 1)
)
select * from opilane;
--andmete lisamine tabelisse
--drop table opilane;
drop table opilane;
insert into opilane(
eesnimi, perenimi, synniaeg, stip, keskmine_hinne)
values(
'Mark', 'Jurgen', '2005-11-15', 1, 4.5), 
(
'Mark2', 'Jurgen2', '2005-11-15', 1, 4.5),
(
'Mark3', 'Jurgen3', '2005-11-15', 1, 4.5),
(
'Mark4', 'Jurgen4', '2005-11-15', 1, 4.5),
(
'Mark5', 'Jurgen5', '2005-11-15', 1, 4.5)
--rida kustutamine, kus on opilaneid=4
delete from opilane where opilaneId=4;
select * from opilane;

--andmete uuendamine
update opilane set aadres='Tallinn'
where opilaneId=3

-------------------------------------------------------------------------------------------------------------------------

CREATE TABLE language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);
select * from language;

insert into language(ID, Code, Language)
values (2, 'RUS', 'vene'), (3, 'ENG', 'inglise'), (4, 'DE', 'saksa')

create table keelevalik
(
keelevalikID int primary key identity(1,1),
valikuNimetus varchar(10) not null,
opilaneId int,
Foreign key (opilaneId) references opilane(opilaneId),
language int,
Foreign key (language) references language(ID)
)
select * from keelevalik;
select * from language;
select * from opilane;

insert into keelevalik(valikuNimetus, opilaneId, language)
values
('valik B', 1, 2), ('valik D', 1, 4),
('valik A', 2, 1), ('valik B', 2, 2),
('valik C', 3, 3), ('valik D', 3, 4),
('valik A', 5, 1), ('valik D', 5, 4)

select * from opilane, language, keelevalik
where opilane.opilaneId=keelevalik.opilaneId
and language.ID=keelevalik.language

select opilane.eesnimi, language.Language
from opilane, language, keelevalik
where opilane.opilaneId=keelevalik.opilaneId
and language.ID=keelevalik.language

delete from keelevalik where keelevalikID=9;

create table oppimine1 
(
oppimineID int primary key identity(1,1),
aine varchar(15) not null,
aasta date, 
opetaja varchar(25) not null,
Foreign key (oppimineID) references opilane(opilaneId),
hinne int
)
insert into oppimine1(aine, aasta, opetaja, hinne)
values
('matemaatika', '2025-12-12', 'Opetaja', 4), ('matemaatika2', '2025-12-12', 'Opetaja2', 5),
('matemaatika3', '2025-12-12', 'Opetaja3', 5), ('matemaatika4', '2025-12-12', 'Opetaja4', 3);

delete from oppimine

select * from keelevalik;
select * from language;
select * from opilane;
select * from oppimine;
