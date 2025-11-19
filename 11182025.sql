﻿--Student ID 67040249108
--Student Name กิติธัช ไชยสัจ

-- *********แบบฝึกหัด Basic Query #2 ***************
 
 --1. จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย เฉพาะสินค้าประเภท Seafood
 --แบบ Product
select ProductID,ProductName,UnitPrice
from Categories as c,Products as p
where c.CategoryID = p.CategoryID and CategoryName = 'Seafood'
--แบบ Join
select ProductID,ProductName,UnitPrice
from Categories as c inner join Products as P on c.CategoryID = p.CategoryID
where CategoryName = 'Seafood'
---------------------------------------------------------------------
--2.จงแสดงชื่อบริษัทลูกค้า ประเทศที่ลูกค้าอยู่ และจำนวนใบสั่งซื้อที่ลูกค้านั้น ๆ ที่รายการสั่งซื้อในปี 1997
--แบบ Product
select CompanyName,Country, COUNT(orderID) as numorders
from Customers as cu, orders as o
where cu.CustomerID = o.CustomerID 
	  AND YEAR(OrderDate) = 1997
group by CompanyName,Country
--แบบ Join
select CompanyName,Country, COUNT(orderID) as numorders
from Customers as cu inner join orders as o on cu.CustomerID = o.CustomerID
where YEAR(OrderDate) = 1997
group by CompanyName,Country
---------------------------------------------------------------------
--3. จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย ชื่อบริษัทและประเทศที่จัดจำหน่ายสินค้านั้น ๆ
--แบบ Product
select ProductID,ProductName,UnitPrice,CompanyName
from Products as p , Suppliers as s
where p.SupplierID = s.SupplierID
--แบบ Join
select ProductID,ProductName,UnitPrice,CompanyName
from Products as p inner join Suppliers as s on p.SupplierID = s.SupplierID

---------------------------------------------------------------------
--4. ชื่อ-นามสกุลของพนักงานขาย ตำแหน่งงาน และจำนวนใบสั่งซื้อที่แต่ละคนเป็นผู้ทำรายการขาย 
--เฉพาะที่ทำรายการขายช่วงเดือนมกราคม-เมษายน ปี 1997 และแสดงเฉพาะพนักงานที่ทำรายการขายมากกว่า 10 ใบสั่งซื้อ 
--แบบ Product
select FirstName+SPACE(3)+Lastname as employeename, Title,
	   count(orderID) as numorders
from Employees as e,Orders as o
where e.EmployeeID = o.EmployeeID
and OrderDate between '1997-01-02' and '1997-04-30'
group by FirstName,LastName,Title
having count(orderID) = 10
--แบบ Join
select FirstName+SPACE(3)+Lastname as employeename, Title,
	   count(orderID) as numorders
from Employees as e inner join Orders as o on e.EmployeeID = o.EmployeeID
where OrderDate between '1997-01-02' and '1997-04-30'
group by FirstName,LastName,Title
having count(orderID) = 10
---------------------------------------------------------------------
--5.จงแสดงรหัสสินค้า ชื่อสินค้า ยอดขายรวม(ไม่คิดส่วนลด) ของสินค้าแต่ละชนิด
--แบบ Product
select p.ProductID,ProductName,sum(od.UnitPrice * Quantity) as sumprice 
from [Order Details] as od , Products as p
where od.ProductID = p.ProductID
group by p.ProductID , ProductName
order by ProductID asc
--แบบ Join
select p.ProductID,ProductName, sum(od.UnitPrice * Quantity) as sumprice 
from [Order Details] as od inner join Products as p on od.ProductID = p.ProductID
group by p.ProductID , ProductName
order by ProductID asc
---------------------------------------------------------------------
/*6.จงแสดงรหัสบริษัทจัดส่ง ชื่อบริษัทจัดส่ง จำนวนใบสั่งซื้อที่จัดส่งไปยังประเทศสหรัฐอเมริกา, 
อิตาลี, สหราชอาณาจักร, แคนาดา ในเดือนมกราคม-สิงหาคม ปี 1997 */
--แบบ Product
select ShipperID,CompanyName,count(OrderID) as NumShipperOrders
from orders as o, Shippers as s
where o.ShipVia = s.ShipperID
and ShipCountry in ('USA','Italy','UK','Canada')
and ShippedDate between '1997-01-01' and '1997-08-31'
group by ShipperID,CompanyName
--แบบ Join
select ShipperID,CompanyName,count(OrderID) as NumShipperOrders
from orders as o inner join Shippers as s on o.ShipVia = s.ShipperID
where ShipCountry in ('USA','Italy','UK','Canada')
and ShippedDate between '1997-01-01' and '1997-08-31'
group by ShipperID,CompanyName
---------------------------------------------------------------------
-- *** 3 ตาราง ****
/*7 : จงแสดงเลขเดือน ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) เฉพาะรายการสั่งซื้อที่ทำรายการขายในปี 1996 
และจัดส่งไปยังประเทศสหราชอาณาจักร,เบลเยี่ยม, โปรตุเกส ของพนักงานชื่อ nancy davolio*/
--แบบ Product
select month(OrderDate) as mounth_No, sum(unitprice * quantity) as SumPrice
from Orders as o,[Order Details] as OD,Employees as e
where o.OrderID = od.OrderID and o.EmployeeID = e.EmployeeID
	  and YEAR(OrderDate) = 1996 
	  and ShipCountry in ('UK','belgium','portugal')
	  and FirstName = 'Nancy' and LastName = 'Davolio'
group by month(OrderDate)
--แบบ Join
select month(OrderDate) as mounth_No, sum(unitprice * quantity) as SumPrice
from Orders as o inner join [Order Details] as OD on o.OrderID =  od.OrderID
				 inner join Employees as e on o.EmployeeID = e.EmployeeID
where YEAR(OrderDate) = 1996 
	  and ShipCountry in ('UK','belgium','portugal')
	  and FirstName = 'Nancy' and LastName = 'Davolio'
group by month(OrderDate)
--------------------------------------------------------------------------------

/*8 : จงแสดงข้อมูลรหัสลูกค้า ชื่อบริษัทลูกค้า และยอดรวม(ไม่คิดส่วนลด) เฉพาะใบสั่งซื้อที่ทำรายการสั่งซื้อในเดือน มค. ปี 1997 
จัดเรียงข้อมูลตามยอดสั่งซื้อมากไปหาน้อย*/
--แบบ Product
select c.CustomerID,CompanyName, sum(UnitPrice * Quantity) as sumprice
from [Order Details] as OD,Orders as o ,Customers as c
where od.OrderID = o.OrderID and o.CustomerID = c.CustomerID
	  and OrderDate between '1997-01-01' and '1997-01-31'
group by c.CustomerID, CompanyName
order by sumprice desc

--แบบ Join
select c.CustomerID,CompanyName, sum(UnitPrice * Quantity) as sumprice
from [Order Details] as OD inner join Orders as o on od.OrderID = o.OrderID
						   inner join Customers as c on o.CustomerID = c.CustomerID
where OrderDate between '1997-01-01' and '1997-01-31'
group by c.CustomerID, CompanyName
order by sumprice desc
---------------------------------------------------------------------------------

/*9 : จงแสดงรหัสผู้จัดส่ง ชื่อบริษัทผู้จัดส่ง ยอดรวมค่าจัดส่ง เฉพาะรายการสั่งซื้อที่ Nancy Davolio เป็นผู้ทำรายการขาย*/
--แบบ Product
select ShipperID,CompanyName,sum(Freight) as sum_Freight
from orders as o,Shippers as s,Employees as e
where o.EmployeeID = e.EmployeeID and o.ShipVia = s.ShipperID
	  and FirstName = 'Nancy' and LastName = 'Davolio'
	  group by ShipperID,CompanyName

--แบบ Join
select ShipperID,CompanyName,sum(Freight) as sum_Freight
from Employees as e inner join orders as o on o.EmployeeID = e.EmployeeID
					inner join Shippers as s on o.ShipVia = s.ShipperID
where FirstName = 'Nancy' and LastName = 'Davolio'
group by ShipperID,CompanyName
---------------------------------------------------------------------------------
/*10 : จงแสดงข้อมูลรหัสใบสั่งซื้อ วันที่สั่งซื้อ รหัสลูกค้าที่สั่งซื้อ ประเทศที่จัดส่ง จำนวนที่สั่งซื้อทั้งหมด ของสินค้าชื่อ Tofu ในช่วงปี 1997*/
--แบบ Product
select o.OrderID,OrderDate,CompanyName,ShipCountry,Quantity
from [Order Details] as od ,orders as o ,Products as p,Customers as c
where od.OrderID = o.OrderID and od.ProductID = p.ProductID and o.CustomerID = c.CustomerID
and ProductName = 'Tofu' and year(OrderDate) = 1997
Order by o.OrderID ASC

--แบบ Join
select o.OrderID,OrderDate,CompanyName,ShipCountry,Quantity
from [Order Details] as od inner join orders as o on od.OrderID = o.OrderID
						   inner join Products as p on od.ProductID = p.ProductID 
						   inner join  Customers as c on o.CustomerID = c.CustomerID
where ProductName = 'Tofu' and year(OrderDate) = 1997
Order by o.OrderID ASC
-----------------------------------------------------------------------------
/*11 : จงแสดงข้อมูลรหัสสินค้า ชื่อสินค้า ยอดขายรวม(ไม่คิดส่วนลด) ของสินค้าแต่ละรายการเฉพาะที่มีการสั่งซื้อในเดือน มค.-สค. ปี 1997*/
--แบบ Product
select p.ProductID,ProductName,sum(od.UnitPrice * quantity) as sumprice
from Products as p, [Order Details] as od, orders as o
where p.ProductID = od.ProductID and od.OrderID = o.OrderID
and OrderDate between '1997-01-01' and '1997-08-31'
group by p.ProductID,ProductName
--แบบ Join
select p.ProductID,ProductName,sum(od.UnitPrice * quantity) as sumprice
from Products as p inner join [Order Details] as od on p.ProductID = od.ProductID
				   inner join orders as o on od.OrderID = o.OrderID
where OrderDate between '1997-01-01' and '1997-08-31'
group by p.ProductID,ProductName
-----------------------------------------------------------------------------
-- *** 4 ตาราง ****
/*12 : จงแสดงข้อมูลรหัสประเภทสินค้า ชื่อประเภทสินค้า ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) เฉพาะที่มีการจัดส่งไปประเทศสหรัฐอเมริกา ในปี 1997*/
--แบบ Product
select c.CategoryID,CategoryName
from Categories as c,Products as p, Orders as o, [Order Details] as od
where c.CategoryID = p.CategoryID 
and p.ProductID = od.ProductID 
and od.OrderID = o.OrderID 
and ShipCountry = 'USA' and year(shippeddate) = 1997
group by c.CategoryID,CategoryName
--แบบ Join
select c.CategoryID,CategoryName
from Categories as c inner join Products as p on c.CategoryID = p.CategoryID
inner join [Order Details] as od on p.ProductID = od.ProductID
inner join orders as o on od.OrderID = o.OrderID
where ShipCountry = 'USA' and year(shippeddate) = 1997
group by c.CategoryID,CategoryName
----------------------------------------------------------------------------
/*13 : จงแสดงรหัสพนักงาน ชื่อและนามสกุล(แสดงในคอลัมน์เดียวกัน) ยอดขายรวมของพนักงานแต่ละคน เฉพาะรายการขายที่จัดส่งโดยบริษัท Speedy Express 
ไปยังประเทศสหรัฐอเมริกา และทำการสั่งซื้อในปี 1997 */
--แบบ Product
select e.EmployeeID,FirstName+'  '+LastName as EmployeeName
from Employees as e,Orders as o,Shippers as s,[Order Details] as od
where e.EmployeeID = o.EmployeeID 
and s.ShipperID = o.ShipVia
and od.OrderID = o.OrderID 
and CompanyName = 'Speedy Express' and ShipCountry = 'USA' and year(OrderDate) = 1997
group by e.EmployeeID,FirstName,LastName
--แบบ Join
select e.EmployeeID,FirstName+'  '+LastName as EmployeeName
from Employees as e inner join Orders as o on e.EmployeeID = o.EmployeeID
					inner join Shippers as s on o.ShipVia = s.ShipperID
					inner join [Order Details] as od on o.OrderID = od.OrderID
where CompanyName = 'Speedy Express' and ShipCountry = 'USA'
and year(OrderDate) = 1997
group by e.EmployeeID,FirstName,LastName
--------------------------------------------------------------------------
/*14 : จงแสดงรหัสสินค้า ชื่อสินค้า ยอดขายรวม เฉพาะสินค้าที่นำมาจัดจำหน่ายจากประเทศญี่ปุ่น และมีการสั่งซื้อในปี 1997 และจัดส่งไปยังประเทศสหรัฐอเมริกา */
--แบบ Product
select p.ProductID, p.ProductName,sum(od.UnitPrice * od.Quantity) as Sumprice
from Products as p, Suppliers as s, [Order Details] as od, Orders as o
where p.SupplierID = s.SupplierID
and p.ProductID = od.ProductID
and od.OrderID = o.OrderID
and s.Country = 'Japan'
and YEAR(OrderDate) = 1997
and ShipCountry = 'USA'
group by p.ProductID, p.ProductName

--แบบ Join
select p.ProductID, p.ProductName,sum(od.UnitPrice * od.Quantity) as SumPrice
from Products as p
inner join Suppliers as s on p.SupplierID = s.SupplierID
inner join [Order Details] as od on p.ProductID = od.ProductID
inner join Orders as o on od.OrderID = o.OrderID
where s.Country = 'Japan'
and YEAR(OrderDate) = 1997
and ShipCountry = 'USA'
group by p.ProductID, p.ProductName;
----------------------------------------------------------------------------
-- *** 5 ตาราง ***
/*15 : จงแสดงรหัสลูกค้า ชื่อบริษัทลูกค้า ยอดสั่งซื้อรวมของการสั่งซื้อสินค้าประเภท Beverages ของลูกค้าแต่ละบริษัท  และสั่งซื้อในปี 1997 จัดเรียงตามยอดสั่งซื้อจากมากไปหาน้อย*/
--แบบ Product
select c.CustomerID, c.CompanyName,sum(od.UnitPrice * od.Quantity) as SumPrice
from Customers as c, Orders as o, [Order Details] as od, Products as p, Categories as ca
where c.CustomerID = o.CustomerID
and o.OrderID = od.OrderID
and od.ProductID = p.ProductID
and p.CategoryID = ca.CategoryID
and ca.CategoryName = 'Beverages'
and YEAR(OrderDate) = 1997
group by c.CustomerID, c.CompanyName
order by SumPrice desc;

--แบบ Join
select c.CustomerID, c.CompanyName,sum(od.UnitPrice * od.Quantity) AS SumPrice
from Customers as c
inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] as od on o.OrderID = od.OrderID
inner join Products as p on od.ProductID = p.ProductID
inner join Categories as ca on p.CategoryID = ca.CategoryID
where ca.CategoryName = 'Beverages'
and YEAR(OrderDate) = 1997
group by c.CustomerID, c.CompanyName
order by SumPrice desc;

---------------------------------------------------------------------------
/*16 : จงแสดงรหัสผู้จัดส่ง ชื่อบริษัทที่จัดส่ง จำนวนใบสั่งซื้อที่จัดส่งสินค้าประเภท Seafood ไปยังประเทศสหรัฐอเมริกา ในปี 1997 */
--แบบ Product
select s.ShipperID, s.CompanyName,COUNT(DISTINCT o.OrderID) AS NumOrders
from Shippers as s, Orders as o, [Order Details] as od, Products as p, Categories as c
where s.ShipperID = o.ShipVia
and o.OrderID = od.OrderID
and od.ProductID = p.ProductID
and p.CategoryID = c.CategoryID
and c.CategoryName = 'Seafood'
and ShipCountry = 'USA'
and YEAR(ShippedDate) = 1997
group by s.ShipperID, s.CompanyName;

--แบบ Join
select s.ShipperID, s.CompanyName,Count(distinct o.OrderID) as NumOrders
from Shippers as s
inner join Orders as o on s.ShipperID = o.ShipVia
inner join [Order Details] as od on o.OrderID = od.OrderID
inner join Products as p on od.ProductID = p.ProductID
inner join Categories as c on p.CategoryID = c.CategoryID
where c.CategoryName = 'Seafood'
and ShipCountry = 'USA'
and YEAR(ShippedDate) = 1997
group by s.ShipperID, s.CompanyName;
---------------------------------------------------------------------------
-- *** 6 ตาราง ***
/*17 : จงแสดงรหัสประเภทสินค้า ชื่อประเภท ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) ที่ทำรายการขายโดย Margaret Peacock ในปี 1997 
และสั่งซื้อโดยลูกค้าที่อาศัยอยู่ในประเทศสหรัฐอเมริกา สหราชอาณาจักร แคนาดา */

--แบบ Product
select c.CategoryID, c.CategoryName,sum(od.UnitPrice * od.Quantity) as SumPrice
from Categories as c, Products as p, [Order Details] as od, Orders as o, Employees as e, Customers as cu
where c.CategoryID = p.CategoryID
and p.ProductID = od.ProductID
and od.OrderID = o.OrderID
and o.EmployeeID = e.EmployeeID
and o.CustomerID = cu.CustomerID
and e.FirstName = 'Margaret'
and e.LastName = 'Peacock'
and YEAR(OrderDate) = 1997
and cu.Country IN ('USA','UK','Canada')
group by c.CategoryID, c.CategoryName;

--แบบ Join
select c.CategoryID, c.CategoryName,sum(od.UnitPrice * od.Quantity) as SumPrice
from Categories as c
inner join Products as p on c.CategoryID = p.CategoryID
inner join [Order Details] as od on p.ProductID = od.ProductID
inner join Orders as o on od.OrderID = o.OrderID
inner join Employees as e on o.EmployeeID = e.EmployeeID
inner join Customers as cu on o.CustomerID = cu.CustomerID
where e.FirstName = 'Margaret'
and e.LastName = 'Peacock'
and YEAR(OrderDate) = 1997
and cu.Country IN ('USA','UK','Canada')
group by c.CategoryID, c.CategoryName;
---------------------------------------------------------------------------
/*18 : จงแสดงรหัสสินค้า ชื่อสินค้า ยอดสั่งซื้อรวม(ไม่คิดส่วนลด) ของสินค้าที่จัดจำหน่ายโดยบริษัทที่อยู่ประเทศสหรัฐอเมริกา ที่มีการสั่งซื้อในปี 1997 
จากลูกค้าที่อาศัยอยู่ในประเทศสหรัฐอเมริกา และทำการขายโดยพนักงานที่อาศัยอยู่ในประเทศสหรัฐอเมริกา */

--แบบ Product
select p.ProductID, p.ProductName,sum(od.UnitPrice * od.Quantity) as sumprice
from Products as p, Suppliers as s, [Order Details] as od, Orders as o, Customers as c, Employees as e
where p.SupplierID = s.SupplierID
and p.ProductID = od.ProductID
and od.OrderID = o.OrderID
and o.CustomerID = c.CustomerID
and o.EmployeeID = e.EmployeeID
and s.Country = 'USA'
and c.Country = 'USA'
and e.Country = 'USA'
and YEAR(OrderDate) = 1997
group by p.ProductID, p.ProductName;

--แบบ Join
select p.ProductID, p.ProductName,sum(od.UnitPrice * od.Quantity) as SumPrice
from Products as p
inner join Suppliers as s on p.SupplierID = s.SupplierID
inner join [Order Details] as od on p.ProductID = od.ProductID
inner join Orders as o on od.OrderID = o.OrderID
inner join Customers as c on o.CustomerID = c.CustomerID
inner join Employees as e on o.EmployeeID = e.EmployeeID
where s.Country = 'USA'
and c.Country = 'USA'
and e.Country = 'USA'
and YEAR(OrderDate) = 1997
group by p.ProductID, p.ProductName

---------------------------------------------------------------------------