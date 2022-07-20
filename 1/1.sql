create table book(
bookid int primary key,
title varchar(30),
pages int,
price number(10,3));

create table author(
authorid int primary key,
author_name varchar(30),
address varchar(30),
bookid references book(bookid)
);

create TABLE student_card(
rollno int primary key,
branch varchar(10),
age int,
bookid references book(bookid),
authorid references author(authorid)
);


select author.authorid,author_name,address,book.bookid,pages from author,book where author.bookid=book.bookid and pages=(SELECT max(pages) FROM book);

select rollno,age,branch from student_card,book where student_card.bookid=book.bookid and title!='OS';

SELECT branch,avg(age) from student_card group by branch;

SELECT rollno,age,branch from student_card,author where student_card.authorid=author.authorid and address='Chennai';