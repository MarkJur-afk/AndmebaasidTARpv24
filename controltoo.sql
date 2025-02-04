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

create procedure opilaneand
@name varchar(25),
@perenimi varchar(25), 
@adress text,
@synniaeg date,
@stip bit, 
@kesk decimal(2,1)
as

begin
insert into opilane(eesnimi, perenimi, synniaeg, aadres, stip, keskmine_hinne)
values (@name, @perenimi, @synniaeg, @adress, @stip, @kesk);

end;

exec opilaneand 'mark', 'jurgen', 'Sõpruse', '2005-05-11', 1, 4.2
drop procedure opilaneand;

select * from opilane;

create procedure opilaneArvuUuendus
@stip bit

as
begin
select * from opilane;
update opilane set stip=@stip
select * from opilane;
end;

exec opilaneArvuUuendus 0;
drop procedure opilaneArvuUuendus;

create procedure nimiOtsing
@nimi char(1)
as
begin
select * from opilane
where eesnimi like @nimi + '%';
 
end;

exec nimiOtsing M;

create procedure kustutaId
@deleteId int
as
begin
select * from opilane;
delete from opilane where opilaneId=@deleteId;
select * from opilane;

end;

exec kustutaId 1;
