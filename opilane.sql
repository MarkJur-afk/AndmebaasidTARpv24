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
