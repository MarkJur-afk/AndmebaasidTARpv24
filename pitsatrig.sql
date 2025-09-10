create database pitseria;
use pitseria;

create table kategooriad(
kategooriaID int identity(1,1) PRIMARY KEY,
nimetus varchar(50)
);

Create table pitsad(
pitsaID int identity(1,1) PRIMARY KEY,
pitsad varchar(15),
aeg int,
töötajanimi varchar(20),
kategooriaID int,
foreign key (kategooriaID) references kategooriad(kategooriaID)
);

Create table logi(
id int identity(1,1) PRIMARY KEY,
aeg DATETIME,
andmed varchar(200),
kasutaja varchar(100)
);

create trigger pitsaLisamine
on pitsad
after insert
as
insert into logi(aeg, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
'Lisatud pitsa: ' + i.pitsad + ', kategooria: ' + k.nimetus
from inserted i
inner join kategooriad k on i.kategooriaID = k.kategooriaID;

create trigger pitsaKustutamine
on pitsad
after delete
as
insert into logi(aeg, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
'Kustutatud pitsa: ' + d.pitsad + ', kategooria: ' + k.nimetus
from deleted d
inner join kategooriad k on d.kategooriaID = k.kategooriaID;

create trigger pitsaUuendamine
on pitsad
after update
as
insert into logi(aeg, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
'Eelmine pitsa: ' + d.pitsad + ', uus pitsa: ' + i.pitsad + ', kategooria: ' + k.nimetus
from inserted i
inner join deleted d on i.pitsaID = d.pitsaID
inner join kategooriad k on i.kategooriaID = k.kategooriaID;

create trigger pitsaLisaminejaKustutamine
on pitsad
after insert, delete
as
insert into logi(aeg, kasutaja, andmed)
select
getdate(),
suser_name(),
concat('Lisatud: ', i.pitsad, ', Töötaja: ', i.töötajanimi, ', Kategooria: ', k.nimetus)
from inserted i
inner join kategooriad k on i.kategooriaID = k.kategooriaID

union all

select
getdate(),
suser_name(),
concat('Kustutatud: ', d.pitsad, ', Töötaja: ', d.töötajanimi, ', Kategooria: ', k.nimetus)
from deleted d
inner join kategooriad k on d.kategooriaID = k.kategooriaID;


--kontroll

insert into kategooriad(nimetus) values ('Klassikaline');
insert into kategooriad(nimetus) values ('Vegaan');
insert into kategooriad(nimetus) values ('Liharikas');


insert into pitsad(pitsad, aeg, töötajanimi, kategooriaID) values ('Meat', 5, 'Ilja', 2);
delete from pitsad where pitsaID=2;


select * from pitsad;
select * from kategooriad;
select * from logi;

update pitsad set pitsad='Margherita' where pitsaID=1;

delete from pitsad where pitsaID=1;

select * from logi;
