(localdb)\mssqllocaldb
--SQL salvestatud protseduur - funktsioon mis käivitab serveris mitu SQL tegevust järjest
--Kasutame SQL server 
create database protseduurJurgen;
use protseduurJurgen;

create table linn(
linnId int primary key identity(1,1),
linnNimi varchar(30),
raahvaArv int);

select * from linn;
insert into linn(linnNimi, raahvaArv)
Values 
('Tallinn', 600000), ('Tartu', 300000), ('Narva', 200000)
--protseduuri loomine
--protseduur, mis lisab uus linn ja kohe näitab tabelis

create procedure lisaLinn
@Lnimi varchar(30), 
@rArv int
AS
begin 

insert into linn(linnNimi, raahvaArv)
values (@Lnimi, @rArv);
select * from linn;

end;

--protseduuri kutse
exec lisaLinn 'Johvi', 10002 
--kirje kustutamine 
delete from linn where linnId=3;


--protseduur, mis kustutab linn id järgi

create procedure kustutaLinn
@deleteId int
as
begin
select * from linn;
delete from linn where linnId=@deleteId;
select * from linn;

end;

--kutse procedure 
exec kustutaLinn 4;
--proceduri kustutamine 
drop procedure kustutaLinn;
drop procedure lisaLinn;

--
create procedure linnaOtsing
@taht char(1)
as
begin
select * from linn
where linnNimi like @taht + '%';
--% - kõik teised tähed 
end;

exec linnaOtsing T;
--------------------------------------------------------------------------------------------------------
kasutame XAMPP / localhost
