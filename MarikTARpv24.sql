create database MarkiTARpv24;
use MarkiTARpv24;

create table linn(
linnId int primary key identity(1,1),
linnNimi varchar(30),
raahvaArv int);

select * from linn;
insert into linn(linnNimi, raahvaArv)
Values 
('Tallinn', 600000)

create procedure lisaLinn
@Lnimi varchar(30), 
@rArv int
AS
begin 

insert into linn(linnNimi, raahvaArv)
values (@Lnimi, @rArv);
select * from linn;

end;

exec lisaLinn 'Johvi', 10002
--veru lisamine 
alter table linn add test int;
--veeru kustutaine 
alter table linn drop column test;

create procedure veeruLisaKustuta
@valik varchar(20),
@veerunimi varchar(20),
@tyyp varchar (20) =null

as

begin 
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then CONCAT('alter table linn add ', @veerunimi, ' ', @tyyp)
when @valik='drop' then CONCAT('alter table linn drop column ', @veerunimi)
end;
print @sqltegevus;
begin 
exec (@sqltegevus);
end
end;

exec veeruLisaKustuta @valik='add', @veerunimi='test3', @tyyp='int';
exec veeruLisaKustuta @valik='drop', @veerunimi='test3';

select * from linn;


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

exec veeruLisaKustutaTabelis  @valik= 'add', @tabel='linn', @veerunimi='test3', @tyyp='int';
exec veeruLisaKustutaTabelis  @valik='drop', @tabel='linn', @veerunimi='test3';
select * from linn;
drop procedure veeruLisaKustutaTabelis
