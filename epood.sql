create database epoodjurgen;
use epoodjurgen;

create table Category(
idCategory int primary key identity(1,1),
CategoryName varchar(25) unique
);
select * from Category;
insert into Category (CategoryName)
values ('jook'), ('sõõk'), ('külm'), ('soe');


--tabeli struktuuri muutmine-->uue vergu lisamine

alter table Category drop column test;
select * from Category;

create table Product (
idProduct int primary key identity(1,1),
ProductName varchar(25),
idCategory int,
Foreign key (idCategory) references Category(idCategory),
Price decimal(5,2)
);
select * from Product;
insert into Product (ProductName, idCategory, Price)
values
('fanat', 1, 2.5), ('cola', 1, 2.2), 
('doshik', 2, 1.3), ('lays', 2, 2.1),
('milk', 7, 1.5), ('sõrok', 7, 0.5),
('chicken', 8, 2.0), ('beef', 8, 2.7); 

delete from Product where idProduct=1
drop table Product;

create table Sale(
idSale int primary key identity(1,1),
idProduct int,
foreign key (idProduct) references Product(idProduct),
idCustomer int,
Count_ int, 
DateOfSale date);
select * from product
select * from Sale;
insert into Sale (idProduct, idCustomer, Count_, DateOfSale)
values
(1, 1, 22, '2025-03-12'), (1, 2, 26, '2025-03-12'),
(1, 3, 23, '2025-03-12'), (1, 4, 27, '2025-03-12'),
(1, 5, 24, '2025-03-12'), (1, 6, 29, '2025-03-12'),
(1, 7, 25, '2025-03-12'), (1, 8, 30, '2025-03-12')



--kustuta kõik kirjed 
delete from sale;

create table customer (
idCustomer int primary key identity(1,1), 
Name varchar(25),
contant text)

select * from customer;
insert into customer(name, contant)
values
('Marek', '12345'), ('Roma', '12346'),
('Martin', '12348'), ('Mark', '12347'),
('Ilja', '12349')

alter table sale add foreign key (idProduct)
references customer(idCustomer)
--tabeli customer 
--tabeli sale 
