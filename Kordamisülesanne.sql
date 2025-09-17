create database triger22tabelid;
use triger22tabelid;

--tabel toode ja toodakategooria on seotud oma vahel
create table toodeKategooria(
toodeKategooriaID int not null primary key identity(1,1),
toodekategooria varchar(100) unique,
kirjeldus text
);

create table toode(
toodeID int not null primary key identity(1,1),
toodeNimetus varchar(100) unique,
hind decimal(5,2),
toodeKategooriaID int,
foreign key (toodeKategooriaID)
references toodeKategooria(toodekategooriaID)
);

create table logi(
logiID int not null primary key identity(1,1),
kuupaev datetime,
kasutaja varchar(100),
andmed text
);

insert into toodeKategooria(toodekategooria)
values ('meelelahutus'), ('joogid'), ('toit'), ('riided'), ('liha');

insert into toodeKategooria(toodekategooria)
values ('vantasteishon');

insert into toode(toodeNimetus, hind, toodeKategooriaID)
values ('kino', 10, 1), ('cola', 1,2), ('doshik', 0.99, 3), ('skidatels', 5, 4), ('sealiha', 2, 5);

select * from toodeKategooria
select * from toode;

--
select toodenimetus, toodekategooria from toode
inner join toodekategooria on toodeKategooria.toodeKategooriaID = toode.toodeKategooriaID

select toodenimetus, toodekategooria from toode
inner join toodekategooria on toodeKategooria.toodeKategooriaID = toode.toodeKategooriaID

select tk.toodekategooria, max(t.hind)
from toode t
inner join toodekategooria tk on t.toodeKategooriaID = tk.toodeKategooriaID
group by tk.toodekategooria

select tk.toodekategooria, count(t.toodeNimetus) as toode_kogus
from toode t
inner join toodekategooria tk on t.toodeKategooriaID = tk.toodeKategooriaID
group by tk.toodekategooria

--
select tk.toodekategooria, cast(avg(t.hind) as decimal(5,2)) as avg_hind
from toode t
inner join toodeKategooria tk
on t.toodeKategooriaID=tk.toodeKategooriaID
group by tk.toodekategooria

--
select tk.toodekategooria, t.toodeNimetus
from toodekategooria tk
left join toode t on t.toodeKategooriaID = tk.toodeKategooriaID
where t.toodeKategooriaID is NULL

select toodenimetus, hind from toode
where hind > (select avg(hind) from toode)


--Loo vaade, mis näitab kõiki tooteid koos kategooria nimega.
create view toode_kategooria
as
select t.toodenimetus, t.hind, tk.toodekategooria from toode t
inner join toodeKategooria tk on tk.toodekategooriaID = t.toodekategooriaID
--kontroll
select * from toode_kategooria;


--Loo vaade, mis kuvab ainult aktiivseid (nt saadaval olevaid) tooteid.
alter table
add aktiivne bit

update toode set aktiivne = 1

select * from toode

update toode set aktiivne = 0
where toodeID = 2


create view saadav_toode
as
select * from toode
where aktiivne =  1
--kontroll
select * from saadav_toode;


--Loo vaade, mis koondab info: kategooria nimi, toodete arv, minimaalne ja maksimaalne hind.
create view KategooriadInfo as
select toodeKategooria,
count(*) as 'Toodete arv',
cast (min(t.hind) as decimal(5, 1)) as 'Min Hind',
cast (max(t.hind) as decimal(5, 1)) as 'Max Hind'
from toodeKategooria tk
inner join toode t  on t.toodeKategooriaID=tk.toodeKategooriaID group by tk.toodekategooria
--kontroll
select * from KategooriadInfo;


--Loo vaade, mis arvutab toode käibemaksu (24%) ja iga toode hind käibemaksuga.
create view toode_kaibemakssuga as
select toodenimetus, hind,
CAST((hind * 0.24) as decimal (5,  2)) as 'kaibemaks',
CAST((hind * 1.24) as decimal (5,  2)) as 'hind_kaibemaks'
from toode;
--kontroll
select * from toode_kaibemakssuga;


--Loo protseduur, mis lisab uue toote (sisendparameetrid: tootenimi, hind, kategooriaID).
create procedure toodese_panna
@toodeNimetus varchar(200),
@hind int,
@toodekategooriaID int
as
begin
insert into toode(toodeNimetus, hind, toodeKategooriaID)
values(@toodeNimetus, @hind, @toodekategooriaID)
select * from toode
end;
--kontroll
exec toodese_panna 'pelmen', 2.5, 5;


--Loo protseduur, mis uuendab toote hinda vastavalt tooteID-le.
create procedure hind_uuendamine
@toodekatgooriaID int,
@Uushind decimal(10,2)
as
begin
update toode
set hind = @Uushind
where toodeKategooriaID = @toodekatgooriaID
select * from toode
end;
--kontroll
exec hind_uuendamine @toodekatgooriaID = 5, @Uushind = 13; 


--Loo protseduur, mis kustutab toote ID järgi.
create procedure KustutaToode
@toodeID int
as 
begin
delete from toode
where toodeID = @toodeID;
select * from toode
end;
--kontroll
exec KustutaToode @toodeID = 3;


--Loo protseduur, mis tagastab kõik tooted valitud kategooriaID järgi.
create procedure LeiaToodekategooriaJargi
@kategooria varchar(30)
as 
begin
select toodeKategooria, toodeNimetus, hind
from toodeKategooria tk
inner join toode t  on t.toodeKategooriaID=tk.toodeKategooriaID
where tk.toodekategooria = @kategooria
end;
--kotroll
exec LeiaToodekategooriaJargi @kategooria = 'liha'


--Loo protseduur, mis tõstab kõigi toodete hindu kindlas kategoorias kindla protsendi võrra.
create procedure TostaHindKategoorias
@kategooriaID int,
@Protsent decimal (5, 2)
as
begin
update toode 
set hind = hind * (1 + @Protsent / 100)
where toodeKategooriaID = @kategooriaID;
select * from toode
end;
--kontroll
exec TostaHindKategoorias @kategooriaID = 5, @Protsent = 50;


--Loo protseduur, mis kuvab kõige kallima toote kogu andmebaasis.
create procedure KalleimToode
as
begin
select t.toodeID, t.toodeNimetus, t.hind, tk.toodekategooria 
from toode t
inner join toodeKategooria tk
on t.toodeKategooriaID = tk.toodeKategooriaID
order by t.hind desc;
select * from toode
end;
--kontroll
exec KalleimToode;

