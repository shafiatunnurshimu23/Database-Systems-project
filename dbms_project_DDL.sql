set pagesize 1000;
set linesize 5000;
set tab off;
set lines 256;
set trimout on;
 

--drop table
drop table purchasement;
drop table customer;
drop table extras;
drop table basicInfo;
drop table body;
drop table engine;


------table creation------

create table customer(
custID varchar(20)  not null,
custName varchar(20) not null,
address varchar(40),
email varchar(30) not null,
phone varchar(15),
primary key(custID)
);

create table body(
bodyID varchar(20) not null,
colour varchar(20),
seats number,
wheelSize varchar(20) check (wheelsize in ('small', 'medium', 'large','','Small', 'Medium', 'Large') ),
height number ,
width number ,
length number ,
primary key(bodyID)
);


create table engine(
    engineID varchar(20) not null,
    engineType varchar(20),
    engineSize varchar(20) check (engineSize in ('small', 'medium', 'large','','Small', 'Medium', 'Large')),
    fuelSystem varchar(20),
    HP number ,
    primary key(engineID)
);


create table basicInfo(
    carID varchar(20) not null,
    bodyID varchar(20),
    engineID varchar(20),
    model varchar(20),
    manufacturer varchar(20),
    price number not null,
    condition varchar(20) check (condition in ('New', 'Used')),
    launchDate date,
    mileage number,
    primary key (carID),
    foreign key (engineID) references engine(engineID) on delete cascade,
    foreign key (bodyID) references body(bodyID) on delete cascade
);
create table extras(
    carID varchar(20) not null,
    autoPilot varchar(20) check (autoPilot in ('Yes', 'No')),
    smartAssistant varchar(20) check (smartAssistant in ('Yes', 'No')),
    GPS varchar(20) check (GPS in ('Yes', 'No')),
    radio varchar(20) check (radio in ('Yes', 'No')),
    primary key (carID),
    foreign key (carID) references basicInfo(carID) on delete cascade 
);

create TABLE purchasement(
    custID varchar(20) NOT NULL,
    carID varchar(20)  NOT NULL,
    no_of_cars number,
    pDate date, 
    PRIMARY KEY (custID,carID),
    Foreign KEY (custID) references customer(custID) on delete cascade,
    Foreign KEY (carID) references basicInfo(carID) on delete cascade
);




          --alter command----

--add column
alter table purchasement add tempCol1 number;
alter table purchasement add tempCol2 VARCHAR(10);
desc purchasement;

--modify column
alter table purchasement modify tempCol1 VARCHAR(10);
desc purchasement;

--drop/delete a column
alter table purchasement drop column tempCol2;
desc purchasement;

--rename a column
alter table purchasement rename column tempCol1 to ABC;
desc purchasement;

--drop extra added column
alter table purchasement drop column ABC;
desc purchasement;

