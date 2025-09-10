create database triger2tabelid; 
use triger2tabelid;

create table toodeKategooria(
toodekategooriaID int not null primary key identity(1, 1),
toodekategooria varchar(100) unique,
kirjeldus text);


create table toode(
toodeID int not null primary key identity(1, 1),
toodeNimetus varchar(100) unique,
hind decimal(5,2),
toodekategooriaID int,
foreign key (toodekategooriaID) 
references toodeKategooria(toodeKategooriaID)
);

insert into toodeKategooria(toodekategooria) 
values ('joogid');
select * from toodeKategooria


insert into toode(toodeNimetus, hind, toodekategooriaID)
values ('kino', 10, 1);

select t.toodeNimetus, t.hind, tk.toodekategooria from toode t
inner join toodeKategooria tk
on t.toodekategooriaID=tk.toodekategooriaID;

--trigerite loomine
--tabel logi
create table logi(
logiID int not null primary key identity(1,1),
kuupaev datetime,
kasutaja varchar(100),
andmed text
)

--trigger mis jalgib insert lisamine tabelillise 
create trigger toodeLisamine
on toode
for insert 
as 
insert into logi(kuupaev, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
CONCAT(inserted.toodeNimetus, ', ', inserted.hind, ', ', tk.toodekategooria)
from inserted
inner join toodeKategooria tk
on inserted.toodekategooriaID=tk.toodekategooriaID;

--kontroll 
insert into toode(toodeNimetus, hind, toodekategooriaID)
values ('kvas', 1.9, 2);
select * from toode;
select * from logi;

create trigger toodeKustutamine
on toode
for delete 
as 
insert into logi(kuupaev, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
CONCAT('kustutatud: ',deleted.toodeNimetus, ', ', deleted.hind, ', ', tk.toodekategooria)
from deleted
inner join toodeKategooria tk
on deleted.toodekategooriaID=tk.toodekategooriaID;


--kontroll
delete from toode where toodeID=1;
select * from toode;
select * from logi;

create trigger toodeUuendamine
on toode
for update 
as 
insert into logi(kuupaev, kasutaja, andmed)
select
getdate(),
SYSTEM_USER,
CONCAT('vanad: ',deleted.toodeNimetus, ', ', deleted.hind, ', ', tk1.toodekategooria, '||' ,
'uued: ', inserted.toodeNimetus, ', ', inserted.hind, ', ', tk2.toodekategooria)
from deleted
inner join inserted on deleted.toodeID=inserted.toodeID
inner join toodeKategooria tk1
on deleted.toodekategooriaID=tk1.toodekategooriaID
inner join toodeKategooria tk2
on inserted.toodekategooriaID=tk2.toodekategooriaID;

--kontroll
update toode set toodekategooriaID=2, toodeNimetus='kvas'
where toodekategooriaID=1;
select * from toode;
select * from logi;


create trigger toodeLisaminejaKustutamine
on toode
after insert, delete
as 
begin
set nocount on;
insert into logi( kuupaev, kasutaja, andmed)
select
getdate(),
SUSER_NAME(),
CONCAT('Lisatud: ',inserted.toodeNimetus, ', ', inserted.hind, ', ', tk.toodekategooria)
from inserted
INNER JOIN toodeKategooria tk
ON inserted.toodekategooriaID = tk.toodekategooriaID;


select
getdate(),
SUSER_NAME(),
CONCAT('kustutatud: ',deleted.toodeNimetus, ', ', deleted.hind, ', ', tk.toodekategooria)
from deleted
INNER JOIN toodeKategooria tk
ON deleted.toodekategooriaID = tk.toodekategooriaID;
END
