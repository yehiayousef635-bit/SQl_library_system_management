# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![Library_project](https://github.com/najirh/Library-System-Management---P2/blob/main/library.jpg)

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup
![ERD](https://github.com/najirh/Library-System-Management---P2/blob/main/library_erd.png)

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
CREATE DATABASE library_db;

--creating branch table
create table branch(
branch_id varchar(10) primary key,	
manager_id	varchar(10),
branch_address	varchar(55),
contact_no varchar(67)
)


-- Create table "Employee"
drop table if exists employees
create table employees(
emp_id varchar(10) primary key ,
emp_name varchar(25),
position varchar(25),
salary decimal,
branch_id varchar(25)
)


-- Create table "Members"
create table members(
member_id varchar(20)primary key,
member_name varchar(59),
member_address varchar(200),
reg_date date
)



-- Create table "Books"
create table books(
isbn varchar(20) primary key,
book_title varchar(100),
category varchar(25),
rental_price float,
status varchar(10),
author varchar(50),
publisher varchar(50)
)


-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
create table issued_status(
issued_id varchar(10)primary key,
issued_member_id varchar(10),
issued_book_name varchar(80),
issued_date date,
issued_book_isbn varchar(50),
issued_emp_id varchar(20)
)



-- Create table "ReturnStatus"
create table return_status(
return_id varchar(10)primary key,
issued_id varchar(10),
return_book_name varchar(50),
return_date date,
return_book_isbn varchar(50)
)

```
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



Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines



## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/najirh/Library-System-Management---P2.git
   ```

2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

## Author -youssef yehia

This project showcases SQL skills essential for database management and analysis. 

GMAIL:yehiayousef635@gmail.com

Thank you for your interest in this project!
