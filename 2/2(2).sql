create table customer(
custno int PRIMARY key,
custname VARCHAR2(10),
city VARCHAR2(10)
);

create table bill(
billno int primary key,
custno REFERENCES customer(custno),
billdate date
);

CREATE TABLE product(
productno int PRIMARY key,
name varchar(10),
unitprice number(7,2) check (unitprice>0)
);

create table billproduct(
billno REFERENCES bill(billno),
productno REFERENCES product(productno),
quantity int check (quantity>0)
);


INSERT into customer values(1,'Deepak','TVM');
INSERT into customer values(2,'Don','CALICUT');
INSERT into customer values(3,'Richu','ERNAKULAM');
INSERT into customer values(4,'Athullya','CALICUT');
INSERT into customer values(5,'Dalvin','ERNAKULAM');
INSERT into customer VALUES(6,'Kavya','TVM');


INSERT into bill VALUES(1,4,'14-Jul-2022');
INSERT into bill VALUES(2,5,'07-Jan-2022');
INSERT into bill VALUES(3,2,'08-Mar-2022');
INSERT into bill VALUES(4,1,'21-Apr-2022');
INSERT into bill VALUES(5,3,'11-Feb-2022');
INSERT into bill VALUES(6,6,'15-Mar-2022');

INSERT INTO product VALUES(11,'Smartphone',21392.32);
INSERT INTO product VALUES(12,'Airpod',6921.11);
INSERT INTO product VALUES(13,'Laptop',69134.12);
INSERT INTO product VALUES(14,'CPU',92192.54);
INSERT INTO product VALUES(15,'Monitor',13532.93);
INSERT INTO product VALUES(16,'Earphone',1250.18);

INSERT INTO billproduct VALUES(3,12,2);
INSERT INTO billproduct VALUES(1,11,2);
INSERT INTO billproduct VALUES(4,14,7);
INSERT INTO billproduct VALUES(2,13,1);
INSERT INTO billproduct VALUES(5,15,2);
INSERT INTO billproduct VALUES(6,16,3);

--1
select c.custname,b.billno,b.billdate from customer c ,bill  b where c.custno=b.custno and b.billno in(
SELECT bp.billno from billproduct bp,product p where bp.productno=p.productno and p.unitprice*bp.quantity >5000);

--2
select c.custname,p.unitprice*bp.quantity as total from customer c,billproduct bp,product p,bill b 
where bp.productno=p.productno 
AND
c.custno=b.custno
AND
b.billno=bp.billno
AND
p.unitprice*bp.quantity> 
(
select sum(p.unitprice*bp.quantity) from billproduct bp,product p where bp.productno=p.productno and bp.billno in(
SELECT bp.billno from billproduct bp,product p where bp.productno=p.productno and bp.billno in(
select b.billno from bill b where b.custno in (select custno from customer where city='CALICUT'))));

--5
select name from product where productno in (SELECT productno from product where unitprice in (select max(unitprice) from product));