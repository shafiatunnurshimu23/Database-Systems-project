-------------------PL/SQL-------------------------



-----variable declaration-------
set serveroutput on
declare
name customer.custName%type;
ID customer.custID%type;
carID purchasement.carID%type;

begin 
----only for single row selection---------
select custID,custName,carID into ID,name,carID from customer natural join purchasement where customer.address like '%California%';
dbms_output.put_line(' ID : '|| ID ||', name : '|| name || ', carID : '|| carID );
end;
/



----insert and set default values------
set serveroutput on
declare 
b purchasement.carID%type := 'CR003';
a  purchasement.custID%type :=  'CT1802';
c  purchasement.no_of_cars%type :=510;
d  purchasement.pDate%type :=TO_DATE('22-FEB-2022');
begin
insert into purchasement values(a,b,c,d);
end;
/
select * from purchasement;
delete from  purchasement where custID='CT1802' and carID='CR003' ;



---rowtype-----
set serveroutput on
declare
a customer%rowtype;
begin
----only for single row selection
select custID,custName,address,phone into a.custID,a.custName,a.address ,a.phone from customer where custID='CT1802';
dbms_output.put_line(' custID : '||a.custID||', custName : '||a.custName||', address : '||a.address||', phone: ' ||a.phone);
end;
/












-----if elsif else----
-- 15% discount on a purcahse of >=1000 cars and 10% on >500 cars 
set serveroutput on
declare
    total_price basicInfo.price%type;
    car_price basicInfo.price%type;
    num purchasement.no_of_cars%type;
    car basicInfo.carID%type :='CR002';
begin
    select price into car_price from basicInfo natural join purchasement where carID=car;
    select no_of_cars into num from basicInfo natural join purchasement where carID=car;
   
    total_price := car_price*num;

    if num>=1000
	then
        total_price :=total_price-(total_price*0.15);
	elsif num>=500
	then
        total_price :=total_price-(total_price*0.1);
    else
        total_price :=total_price;
    end if;

    dbms_output.put_line('Total bill for ordering '||num||' '||car||' is : '||total_price);

end;
/




--PL/SQL normal loop example----

set serveroutput on
declare
    counter number :=1;
begin
    loop
        dbms_output.put_line('counter is now '||counter);
		counter:=counter+1;
        exit when counter=5;
   end loop;
end;
/




------Cursor , row count and loop------
-- purchasement of  a customer whose  id='CT1804' and name='Miachael Morbius'
set serveroutput on
declare
 
cursor c is select * from purchasement where custID='CT1804';
a purchasement%rowtype;
begin
open c;
fetch c into a.custID,a.carID,a.no_of_cars,a.pDate;

while c%found
loop
dbms_output.put_line(' Id : '||a.custID||', car_id : '||a.carID||', no_of_cars : '||a.no_of_cars||', pDate : '||a.pDate);
dbms_output.put_line('row count : '||c%rowcount);
fetch c into a.custID,a.carID,a.no_of_cars,a.pDate;
end loop;
close c;
end;
/



-----array-----
-------array of car Model showing by given carID------
set serveroutput on
declare
cursor c2 is select carID from basicInfo;
type arrayName is varray(10) of basicInfo.model%type;
ar arrayName := arrayName();
counter number ;
b basicInfo.model%type;
a basicInfo.carID%type;


begin
counter := 1;
open c2;
fetch c2 into a;
while c2%found
loop
select model into b from basicInfo where carID=a;
ar.extend();
ar(counter) := b;
counter := counter +1 ;
fetch c2 into a;
end loop;
close c2;


counter :=1;
while counter<=ar.count
loop 
dbms_output.put_line(ar(counter));
counter := counter+1;
end loop;
end;
/



--PL/SQL procedures-----
--printing body features where carID is given

set serveroutput on
create or replace procedure getBodyInfo(a in basicInfo.carID%type) is 
b body%rowtype;
cursor c is select bodyID,colour,seats,wheelSize,height,width,length from body where bodyID=(select bodyID from basicInfo where carID=a);

begin
open c;
fetch c into b.bodyID,b.colour,b.seats,b.wheelSize,b.height,b.width,b.length;
while c%found
loop 
dbms_output.put_line('carID : '||a||', bodyID :'||b.bodyID||', colour: '||b.colour||', seats: '||b.seats||', wheelSize : '||b.wheelSize||', height : '||b.height||', width : '||b.width||', lenght : '||b.length);
fetch c into b.bodyID,b.colour,b.seats,b.wheelSize,b.height,b.width,b.length;
end loop;
close c;
end;
/

begin
getBodyInfo('CR001');
end;
/



--PL/SQL functions-------
--calculation of bill for a purchasement
set serveroutput on
create or replace function bill_calculation(price in basicInfo.price%type, num in purchasement.no_of_cars%type)
    return number is
begin
    return (price*num);
end bill_calculation;
/

set serveroutput on
declare
    cursor c is select model, price, no_of_cars, custName from basicInfo join purchasement
   on basicInfo.carID=purchasement.carID join customer on purchasement.custID=customer.custID;
    var1 c%rowtype;
    
begin
    open c;
	fetch  c into var1;
    while c%found
	loop   
   dbms_output.put_line('Customer: '||var1.custName||'  Model: '||var1.model||'  Price: '||var1.price||'  no_of_cars: '||var1.no_of_cars||'  Total bill : '||bill_calculation(var1.price,var1.no_of_cars));
   fetch  c into var1;
   end loop;
    close c;
end;
/


--outro------
set SERVEROUTPUT on;
begin
dbms_output.put_line('    ');
dbms_output.put_line('    ');
dbms_output.put_line('    ');
dbms_output.put_line('    ');
dbms_output.put_line('-------------------------------------------------------------------------------------------------------- ');
dbms_output.put_line('Project Name : ');
dbms_output.put_line('Vehicle Management System');
dbms_output.put_line('-------------------------');
dbms_output.put_line('Created by : ');
dbms_output.put_line('Mst. Shafiatun Nur Shimu');
dbms_output.put_line('-------------------------');
dbms_output.put_line('Roll : ');
dbms_output.put_line('1907001');
dbms_output.put_line('-------------------------');
end;
/
-----

-----


------------------------------------------------------------------------
---task1
set serveroutput on
create or replace procedure getCustName(x in basicInfo.model%type) is 

cursor c is select custName from customer where custID=(select custID from purchasement where carID=(select carID from basicInfo where model=x)) ;
b c%rowtype;
begin
open c;
fetch c into b;
while c%found
loop 
dbms_output.put_line('Customer Name : '||b.custName || 'Model of Car : '||x);
fetch c into b;
end loop;
close c;
end;
/

begin
getCustName('LaFerrari');
end;
/

------task2--
select max(HP) from engine join basicInfo on basicInfo.engineID=engine.engineID join purchasement using(carID) group by custID ;

select max(HP),custName from engine join basicInfo on basicInfo.engineID=engine.engineID join purchasement using(carID) join customer using(custID) group by custName ;













----
