----------Data insertion----------


--customer
Insert into customer values('CT1807','Christopher Nolan','222B Baker Street London','nolan123@gmail.com',831671261);
Insert into customer values('CT1808','Curtis Mayfield','378 Eagle Lane Minnesota','cmf399@gmail.com',795289377);
Insert into customer values('CT1803','Robert Pattinson','2129 Wilson Street California','pattinson56@yahoo.com',603802256);
Insert into customer values('CT1801','Sadie Sink','1546 Pleasant Hill Road California','sadsink@gmail.com',595219298);
Insert into customer values('CT1806','Maxine Mayfield','2098 Juniper Drive Michigan','maxx44@yahoo.com',962343534);
Insert into customer values('CT1804','Miachael Morbius','2753 Armory Road North Carolina','morbin@marvel.com',831642069);
Insert into customer values('CT1802','Alfred','1109 Armory Road North London','morbin@marvel.com',831642069);

--engine
Insert into engine VALUES('EG041','Combustion','medium','Diesel',1000);
Insert into engine VALUES('EG042','Electric','medium','',900);
Insert into engine VALUES('EG044','Combustion','large','Gasoline',1200);
Insert into engine VALUES('EG045','Combustion','large','Octane',1400);
Insert into engine VALUES('EG046','Hybrid','large','Octane',1000);
Insert into engine VALUES('EG047','Electric','large','',1300);


--body
insert into body VALUES('BD001','white',4,'medium',14.5,9.5,22.5);
insert into body VALUES('BD002','red',2,'small',12.5,7.5,18.5);
insert into body VALUES('BD003','purple',10,'large',16.5,12.5,25.5);
insert into body VALUES('BD004','white',4,'medium',14.5,9.5,22.5);
insert into body VALUES('BD005','black',4,'medium',14.5,9.5,22.5);

--basicinfo
insert into basicinfo VALUES('CR001','BD001','EG041','LaFerrari','Ferrari',5000000,'New',TO_DATE('24-May-2005'),40);
insert into basicinfo VALUES('CR003','BD005','EG042','Model S','Tesla',95000,'New',TO_DATE('22-Jun-2012'),400);
insert into basicinfo VALUES('CR005','BD002','EG041','4c Spider','Alfa Romeo',68500,'New',TO_DATE('20-Jan-2020'),50);
insert into basicinfo VALUES('CR002','BD005','EG041','Shelby GT500','Ford',50000,'Used',TO_DATE('24-May-2006'),70);
insert into basicinfo VALUES('CR009','BD005','EG044','Noah 2014','Toyota',8500,'Used',TO_DATE('24-May-2014'),50);
insert INTO basicinfo VALUES('CR010','BD003','EG044','Noah 2014','Toyota',8500,'Used',TO_DATE('24-May-2014'),50);


--extras
insert into extras VALUES('CR001','No','Yes','Yes','Yes');
insert into extras VALUES('CR003','Yes','Yes','Yes','Yes');
insert into extras VALUES('CR005','No','Yes','Yes','Yes');
insert into extras VALUES('CR009','No','No','Yes','Yes');
insert into extras VALUES('CR002','No','Yes','Yes','Yes');

--purchasement
insert into purchasement VALUES('CT1804','CR001',5000,TO_DATE('22-JAN-2022'));
insert into purchasement VALUES('CT1804','CR003',23000,TO_DATE('22-JAN-2022'));
insert into purchasement VALUES('CT1804','CR005',4400,TO_DATE('22-JAN-2022'));
insert into purchasement VALUES('CT1804','CR009',52300,TO_DATE('22-JAN-2022'));
insert into purchasement VALUES('CT1804','CR002',50330,TO_DATE('22-JAN-2022'));
insert INTO purchasement VALUES('CT1801','CR005',5010,TO_DATE('22-FEB-2022'));
insert INTO purchasement VALUES('CT1802','CR010',1010,TO_DATE('22-FEB-2022'));



----------Queries----------


-- show user name----
show user;

---- show the list of tables-----
select table_name from user_tables;

----- show all tables and views from the tab----
select * from tab;

----- descriptions of table----
desc basicinfo;
desc engine;
desc body;
desc extras;
desc customer;
desc purchasement;

       --show data---
select * from basicinfo;
select * from engine;
select * from body;
select * from extras;
select * from customer;
select * from purchasement;

     -----basic select commands-----
select distinct custName from customer;
select  all custName from customer;
select bodyID,height/2 as half_height, length,width from body ;

----- basic where clause----
select * from basicInfo where bodyID='BD005' and price>=6000;


---cartesian product-----
select * from body,engine;
select * from basicInfo b,engine e where b.engineID=e.engineID ;



         --------update command---------

SELECT * FROM customer;
update customer SET custName='Rahim Mia' where custID='CT1807';
SELECT * FROM customer;

update customer SET custName='Rahim Mia',email='rahim@gmail.com',phone='01752015711' where custID='CT1807';
SELECT * FROM customer;


         -------delete command--------

Insert into customer values('CT1810','chadwik','1200 Armory Road North Carolina','chadwik@marvel.com',831642069);
SELECT * from customer;
delete from customer where CustID='CT1810';
SELECT * from customer;


        ------applying conditions-------

select custName, address, email from customer where custID='CT1807';
select colour, seats, height from body where bodyID='BD001';



        ------range search-----

select custID, carID, pDate,no_of_cars from purchasement where no_of_cars between 20000 AND 60000;
select custID, carID, pDate,no_of_cars from purchasement where no_of_cars>=4000 AND no_of_cars<=25000;



       --set membership---

select custID, carID, pDate,no_of_cars from purchasement where no_of_cars in(4400,23000);



         ----string operations-----

--start with 'R
select custID,custName from customer where custName like 'R%'; 
--name contains 'R' or 'r'
select custID,custName from customer where custName like '%R%' or custName like '%r%';
--name ends with R or  r
select custID,custName from customer where custName like '%S' or custName like '%s';
--start with 'R and ends with a
select custID,custName from customer where custName like 'R%' and custName like '%a';
--name contains 2 'M' i.e 'MM'
select custID,custName from customer where custName like '%M%M%';



           -------order by-------

select * from basicInfo order by carID;
select * from basicInfo order by carID desc;
select b.carID,b.price,e.engineID,e.engineType from basicInfo b,engine e  where b.engineID=e.engineID order by price ;
select b.carID,b.price,e.engineID,e.engineType from basicInfo b,engine e  where b.engineID=e.engineID order by e.engineType;





      ----aggregate functions----
select carID as best_selling_car,no_of_cars from purchasement where no_of_cars=(select max(no_of_cars) from purchasement) ;
select carID as least_selling_car,no_of_cars from purchasement where no_of_cars=(select min(no_of_cars) from purchasement) ;
select COUNT(*)as total_purchasement from purchasement;
select sum(Price),avg(Price) from basicinfo;

--group by clause----
select custID,COUNT(carID) as total_type,SUM(no_of_cars) as total_no_of_cars from purchasement group by custID;



--having clause-----
select custID,count(CarID) from purchasement
group by custID
having SUM(no_of_cars)>10000;



--------nested subquery---------
select * from customer where
custID=(select custID from purchasement where 
carID=(select carID from basicInfo where 
bodyID=(select bodyID from body where colour='purple')));



--null values----
select * from engine where fuelSystem is null;


------------------------------------------------------------------------
----set operations----


--union all operation
--union of customers living in california and customers who made a purchase

select custName,address from customer where address like '%California%'
union all  
select customer.custName,customer.address from customer,purchasement where customer.custID=purchasement.custID;



--union operaton
--union of customers living in california and customers who made a purchase(no duplication)

select custName,address from customer where address like '%California%'
union   
select customer.custName,customer.address from customer,purchasement where customer.custID=purchasement.custID;


--intersection operation
--intersection of customers living in california and customers who made a purchase

select custName,address from customer where address like '%California%'
intersect   
select customer.custName,customer.address from customer,purchasement where customer.custID=purchasement.custID;


--minus operation
--all customers minus the customers who made a purchase
select custName from customer
minus      
select c.custName from customer c where c.custName IN( select cc.custName from customer cc, purchasement p where p.custID=cc.custID);

---except
--select custName from customer
--except
--(select custName from customer where address like '%California%');

-------set membership--------

------in and not in--------
select carID,custID from purchasement where custID in (select custID from customer where address like '%London%');
select carID,custID from purchasement where custID not in (select custID from customer where address like '%California%');

----some and all--------
select * from basicInfo where price> some(select price from basicInfo where price>=50000);
select * from basicInfo where price> all(select price from basicInfo where price>=50000);

---exists------
select * from basicInfo where price>=50000 and exists(select * from customer where custName like '%M%M%');


----------------------------------------------------------------------------------

------join operations------

--natural join------
select * from customer natural join purchasement ;
select * from customer natural join purchasement where no_of_cars>50000;


------join------
select custName, address, email, carID from customer join purchasement using(custID) where no_of_cars>50000;
select custName, address, email, carID from customer join purchasement on customer.custID=purchasement.custID where no_of_cars>50000;

--cross join---
select * from customer cross join purchasement where no_of_cars>50000;

--Outer join---
select * from basicinfo outer join extras on smartAssistant='Yes';

----left outer join----
select custName, address, email, carID from customer left outer join purchasement using(custID);

----right outer join----
select custName, address, email, carID from customer right outer join purchasement using(custID);

----full outer join----
select custName, address, email, carID from customer full outer join purchasement using(custID);



------------------------------------------------------------------------

-------View-------

----read only views-----
create view customer_details as select custID,address,phone from customer;
select * from customer_details;
desc customer_details;

create view car_body_details as select carID,model,price from basicInfo where bodyID=
(select bodyID from body where colour='black');
select * from car_body_details;

---view from another view-----
create view temp as select * from customer_details;

----view drop------
drop view car_body_details;
drop view customer_details;
drop view temp;
