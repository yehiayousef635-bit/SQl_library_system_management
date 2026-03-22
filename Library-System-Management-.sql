--library management system project
--creating branch table
create table branch(
branch_id varchar(10) primary key,	
manager_id	varchar(10),
branch_address	varchar(55),
contact_no varchar(67)
)

--create table employees
drop table if exists employees
create table employees(
emp_id varchar(10) primary key ,
emp_name varchar(25),
position varchar(25),
salary decimal,
branch_id varchar(25)
)

--create table books
create table books(
isbn varchar(20) primary key,
book_title varchar(100),
category varchar(25),
rental_price float,
status varchar(10),
author varchar(50),
publisher varchar(50)
)
--create table members
create table members(
member_id varchar(20)primary key,
member_name varchar(59),
member_address varchar(200),
reg_date date
)
--create table issued_status
create table issued_status(
issued_id varchar(10)primary key,
issued_member_id varchar(10),
issued_book_name varchar(80),
issued_date date,
issued_book_isbn varchar(50),
issued_emp_id varchar(20)
)
--create table return_status
create table return_status(
return_id varchar(10)primary key,
issued_id varchar(10),
return_book_name varchar(50),
return_date date,
return_book_isbn varchar(50)
)
--foreign key
alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id)

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn)

alter table employees
add constraint pk_employees
foreign key (emp_id)
references return_status(return_id)



alter table employees
add constraint pk_employe
foreign key (branch_id)
references branch(branch_id)

alter table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id)

--project tasks
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird','Classic',6,'yes','hyper lee', 'J.B. Lippincott & Co.')


-- Task 2: Update an Existing Member's Address
update members
set member_address='125 oak street'
where member_id='C103'


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issued_status
where issued_id='is121'

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select
issued_emp_id,
count(issued_id)
from issued_status
group by issued_emp_id
having  count(issued_id)>1

-- CTAS
-- Task 6: Create Summary Tables: Used cte to generate new tables based on query results - each book and total book_issued_cnt**
create table book_cte as
select
b.isbn,
b.book_title,
count(i.issued_id)total_books
from books as b
join issued_status as i
on i.issued_book_isbn=b.isbn
group by b.book_title,1

select
*
from book_cte

-- Task 7. Retrieve All Books in a Specific Category

select
count(category)total_books,
book_title
from books
group by book_title

-- Task 8: Find Total Rental Income by Category

select
category,
sum(rental_price)total_rental
from books
group by category

-- List Members Who Registered in the Last 180 Days

select
*
from members
where reg_date>=current_date-interval'180 days'

-- q 10 List Employees with Their Branch Manager's Name and their branch details:

SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name as manager
FROM employees as e1
JOIN  
branch as b
ON b.branch_id = e1.branch_id
JOIN
employees as e2

ON b.manager_id = e2.emp_id

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
create table books_above_7
as
select
*
from books
where rental_price>7

select
*
from books_above_7

-- Task 12: Retrieve the List of Books Not Yet Returned

select
 DISTINCT i.issued_book_name
from issued_status i
left join return_status r
on i.issued_id=r.issued_id
where r.return_date is null

--end project





































