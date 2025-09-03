create database Jurgentriger;
use Jurgentriger;

Create table linnad(
linnID int identity(1,1) PRIMARY KEY,
linnanimi varchar(15),
rahvaarv int);

--tabel logi näitab adminile kuidas tabel linnad
--kasutatakse, tabel logi täidab triger
Create table logi(
id int identity(1,1) PRIMARY KEY,
aeg DATETIME,
toiming  varchar(100),
andmed varchar(200),
kasutaja varchar(100)
)

--insert trigger, mis jalgib tabeli linnad täitmine
create trigger linnaLisamine
on linnad
for insert 
as
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
SYSTEM_USER,
'linn on lisatud',
inserted.linnanimi
from inserted;

--trigeri tegevuse kontroll
insert into linnad (linnanimi, rahvaarv)
values ('Tallinn', 650000);
select * from linnad;
select * from logi;

--delete trigger, jälgib linna kustutamine tabelis linnad
create trigger linnaKustutamine
on linnad
for delete 
as
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
SYSTEM_USER,
'linn on kustutatud',
deleted.linnanimi
from deleted;
--kontroll
delete from linnad where linnID=1;
select * from linnad;
select * from logi;

--update trigger
create trigger linnaUendamine
on linnad
for update 
as
insert into logi(aeg, kasutaja, toiming, andmed)
select 
getdate(),
SYSTEM_USER,
'linn on uuendatud',
concat('vanad andmed:', deleted.linnanimi, ' ,',deleted.rahvaarv,
'uued andmed: ', inserted.linnanimi, ' ,',inserted.rahvaarv)
from deleted
inner join inserted
on deleted.linnID=inserted.linnID;
--kontroll
update linnad set rahvaarv= 650001
where linnID=2;
select * from linnad;
select * from logi;

disable trigger linnaLisamine on linnad
--kontrolli
insert into linnad (linnanimi, rahvaarv)
values ('Tartu', 300000);
select * from linnad;
select * from logi;

enable trigger linnaLisamine on linnad

--Kasutaja nimega sekretarMarkJurgen parooliga 'kala' 
--ja sekretarMarkJurgen ei näe tabeli logi ja ei saa trigerid muuta/kustutada

grant delete, update on linnad to sekretarMarkJurgen;

drop trigger linnaKustutamine;
