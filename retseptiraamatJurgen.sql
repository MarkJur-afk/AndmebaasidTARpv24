create database retseptiraamatJurgen; 
use retseptiraamatJurgen;
create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar(150));

insert into kasutaja(eesnimi,perenimi,email)
values
('Roma', 'Ztsev', 'romagmail.com'),
('Martn', 'Rosak', 'martingmail.com'),
('Nikita', 'Litv', 'nikitagmail.com'),
('Ilja', 'Jun', 'iljagmail.com');


select * from kasutaja;

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));

insert into kategooria(kategooria_nimi)
values
('meet'), ('chees'), ('magusad'), ('solased'), ('suppid');

select * from kategooria;

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100)not null);

insert into toiduaine(toiduaine_nimi)
values
('milk'), ('sool'), ('sugar'), ('juust'), ('liha'), ('munad');
select * from toiduaine;


create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));

insert into yhik(yhik_nimi)
values
('ml'), ('tl'), ('sl'), ('g'), ('kg');
select * from yhik;

create table retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(200),
juhen varchar(500),
sisetatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
kategooria_id int,
foreign key (kategooria_id) references kategooria(kategooria_id));

insert into retsept(retsepti_nimi, kirjeldus, juhen, sisetatud_kp, kasutaja_id, kategooria_id)
values 
('tort', 'väga magus', 'sega kõike', '2025-03-03', 1, 1),
('võileib juustuga', 'võileib, juust', 'sega kõike', '2025-03-03', 2, 2),
('kohupiim meega', 'kohupiim, mee', 'sega kõike', '2025-03-03', 3, 3)

create procedure lisaretsept
@retsepti_nimi varchar(100), 
@kirjeldus varchar(200),
@juhen varchar(500),
@sisetatud_kp date,
@kasutaja_id int,
@kategooria_id int
as
begin 

insert into retsept(retsepti_nimi, kirjeldus, juhen, sisetatud_kp, kasutaja_id, kategooria_id)
values (@retsepti_nimi, @kirjeldus, @juhen, @sisetatud_kp, @kasutaja_id, @kategooria_id);
select * from retsept;
end;
exec lisaretsept 'kohupiim meega', 'kohupiim, mee', 'sega kõike', '2025-03-03', 4, 4


create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int,
foreign key (retsept_retsept_id) references retsept(retsept_id),
toiduaine_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
yhik_id int,
foreign key (yhik_id) references yhik(yhik_id));

insert into koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values
(2, 2, 1, 1), (3, 3, 2, 2), (6, 4, 3, 3);

create procedure lisakoostis
@kogus varchar(30), 
@retsept_retsept_id int,
@toiduaine_id int,
@yhik_id int
AS
begin 

insert into koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values (@kogus, @retsept_retsept_id, @toiduaine_id, @yhik_id);
select * from koostis;

end;
exec lisakoostis 6, 5, 3, 3

select * from koostis;

create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));

insert into tehtud(tehtud_kp, retsept_id)
values
('2025-03-12', 2), ('2025-03-10', 3), ('2025-02-12', 4);

create procedure Lisatehtud
@tehtud_kp date, 
@retsept_id int
AS
begin 

insert into tehtud(tehtud_kp, retsept_id)
values (@tehtud_kp, @retsept_id);
select * from tehtud;

end;

exec Lisatehtud '2025-02-12', 5


create table hind(
hind_id int primary key identity(1,1),
hind int, 
toiduaine_id int,
Foreign key (toiduaine_id) references toiduaine(toiduaine_id));

select *from hind;
insert into hind(hind, toiduaine_id)
values
(25, 1), (30, 2), (45, 3), (12, 4), (14, 5);

create procedure lisahind
@hind int, 
@toiduaine_id int
AS
begin 

insert into hind(hind, toiduaine_id)
values (@hind, @toiduaine_id);
select * from hind;

end;

create procedure Kustutahind
@deleteId int
as
begin
select * from hind;
delete from hind where hind=@deleteId;
select * from hind;

end;



select * from retsept;
select * from toiduaine;
select * from yhik;
select * from kasutaja;
select * from kategooria;
select * from tehtud;
select * from koostis;

create procedure veeruLisaKustutaTabelis
@tabel varchar (20),
@valik varchar(20),
@veerunimi varchar(20),
@tyyp varchar (20) =null
as

begin 
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then CONCAT(' alter table ', @tabel, ' add ', @veerunimi, ' ', @tyyp)
when @valik='drop' then CONCAT( 'alter table ', @tabel, ' drop column ', @veerunimi)
end;
print @sqltegevus;
begin 
exec (@sqltegevus);
end
end;
exec veeruLisaKustutaTabelis  @valik= 'add', @tabel='yhik', @veerunimi='test3', @tyyp='int';
exec veeruLisaKustutaTabelis  @valik='drop', @tabel='yhik', @veerunimi='test3';





