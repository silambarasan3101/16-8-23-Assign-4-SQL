create database Assessment4Db
use Assessment4Db
--create products table
create table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float not null,
PTax as PPrice*0.10 persisted,
PCompany nvarchar(50),
PQty int default 10,
check(PQty>=1))

--Insert data into table
insert into Products (PName, PPrice, PCompany, PQty) values ('Samsung Galaxy', 50000, 'Samsung',11)
insert into Products (PName, PPrice, PCompany, PQty) values ('iPhone14', 750000, 'Apple', 17)
insert into Products (PName, PPrice, PCompany, PQty) values ('Redmi Note 5', 13000, 'Redmi',15)
insert into Products (PName, PPrice, PCompany) values ('HTC One', 51000, 'HTC')
insert into Products (PName, PPrice, PCompany) values ('RealMe 8', 27000, 'RealMe')
insert into Products (PName, PPrice, PCompany, PQty) values ('Xiaomi Mi 9+', 12500, 'Xiaomi',25)
insert into Products (PName, PPrice, PCompany, PQty) values ('Samsung A21', 14000, 'Samsung',15)
insert into Products (PName, PPrice, PCompany, PQty) values ('iPhone SE', 35000, 'Apple',26)
insert into Products (PName, PPrice, PCompany, PQty) values ('Redmi 9', 17000, 'Redmi',23)
insert into Products (PName, PPrice, PCompany) values ('HTC Desire', 11000, 'HTC')

drop table Products
--PId, PName, PPrice with PTax, PCompany, TotalPrice(PQty * PPrice with Tax)
create proc usp_DispPro
with encryption
as
select PId, PName, PPrice, PTax, (PPrice+PTax) as 'Price_with_Tax', PCompany, PQty, PQty * (PPrice + PTax) AS TotalPrice
from Products

drop proc usp_DispPro
--executing the display procedure
exec usp_DispPro

--creating a procedure that returns 
--total tax of PCompany that we pass as an input parameter and total tax is returned as output parameter
create proc usp_CalcTotTax
@company nvarchar(50),
@totaltax float output
with encryption
as
select @totaltax = sum(PTax)
from Products
where PCompany = @company

declare @totaltax float
exec usp_CalcTotTax @company = 'Samsung', @totaltax = @totaltax output
select @totaltax as 'TotalTax'