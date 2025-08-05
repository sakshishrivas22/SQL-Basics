### Q.1 Create a table called employees with the following structure
## emp_id (integer, should not be NULL and should be a primary key)
## emp_name (text, should not be NULL)
## age (integer, should have a check constraint to ensure the age is at least 18)
## email (text, should be unique for each employee)
## salary (decimal, with a default value of 30,000).
## Write the SQL query to create the above table with all constraints.

create database ABC_Company;
use ABC_Company;
create table employees(emp_id int primary key, emp_name varchar(50) not null, 
age int check(age >= 18), email varchar(100) unique, salary float default 30000);

##Q.2 Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
## examples of common types of constraints

-- ANS:- Purpose of Constraints:
-- Ensure valid, consistent, and reliable data
-- Enforce business rules at the database level
-- Prevent duplicate, null, or incorrect data entries

-- Common Types of Constraints:
-- NOT NULL – Ensures a column cannot have a NULL value
-- Example: name VARCHAR(50) NOT NULL

-- UNIQUE – Ensures all values in a column are different
-- Example: email VARCHAR(100) UNIQUE

-- PRIMARY KEY – Uniquely identifies each row; combination of NOT NULL + UNIQUE
-- Example: id INT PRIMARY KEY

-- FOREIGN KEY – Maintains referential integrity between tables
-- Example: customer_id INT REFERENCES customers(id)

-- CHECK – Ensures values meet a specific condition
-- Example: age INT CHECK(age >= 18)

-- DEFAULT – Sets a default value if none is provided
-- Example: status VARCHAR(10) DEFAULT 'active'

## Q.3 Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify 
## your answer

-- ANS :- The NOT NULL constraint is applied to a column to ensure that it must always have a value—no empty or missing data is allowed. This helps maintain data completeness.
-- A Primary Key cannot contain NULL values because it is used to uniquely identify each record in a table. Allowing NULLs would break this rule, as NULL means "unknown" and cannot guarantee uniqueness.
-- In short:
-- NOT NULL ensures required data.
-- Primary Key must be NOT NULL and UNIQUE to maintain record identity

## Q.4  Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
## example for both adding and removing a constraint

-- ANS:- To add a constraint to an existing table, we use the ALTER TABLE command with ADD CONSTRAINT followed by the constraint type and details.
-- To remove a constraint, we use the ALTER TABLE command with DROP CONSTRAINT and specify the name of the constraint we want to delete.
-- For example, to add a unique constraint on an email column, we write ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);.-- To remove the same constraint, we write ALTER TABLE employees DROP CONSTRAINT unique_email;.
 
-- example for both adding and removing a constraint:-

-- 1:- ALTER TABLE employees
--    ADD CONSTRAINT unique_email UNIQUE(email);

-- 2:- ALTER TABLE employees
--    DROP CONSTRAINT unique_email;

## Q.5  Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
## Provide an example of an error message that might occur when violating a constraint

-- ANS:- If we try to insert, update, or delete data in a way that breaks a constraint (rule) in the database, the database will stop the action and show an error message.
-- Consequences:
-- The data will not be saved or updated.
-- Wrong or incomplete data will not enter the database.
-- The database will keep its data correct (data integrity).
-- Example error message:-- ERROR: Cannot insert NULL value into column 'StudentID'; column does not allow nulls.

## Q.6 You created a products table without constraints as follows:
 ## CREATE TABLE products (
 ## product_id INT,
 ## product_name VARCHAR(50),
 ## price DECIMAL(10, 2));  
 ## Now, you realise that
 ## The product_id should be a primary key
 ## The price should have a default value of 50.00

-- ANS:- 
use pw;
create table products(product_id int, product_name varchar(50), 
price decimal(10,2));

ALTER TABLE products
ADD CONSTRAINT primary_pro_id primary key(product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00; 

## Q.7 you have two tables (1) Students , (2) Classes:
## Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

use college;

CREATE TABLE Students(student_id int primary key, student_name varchar(50) not null,
class_id int );
insert into Students (student_id, student_name, class_id) values (1,"Alice", 101), (2,"Bob", 102),
(3,"Charlie", 101);
select * from Students;

CREATE TABLE Classes(class_id int primary key, class_name varchar(50) not null);
insert into Classes(class_id, class_name) values (101,"Math"),(102,"Science"),(103,"History");
select * from Classes;

select student_name,class_name from Students inner join Classes
on Students.class_id = Classes.class_id;

## Q.8 Consider the following three tables:
## (1) Orders (2) Customers (3) Products
##  Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
## listed even if they are not associated with an order 
## Hint: (use INNER JOIN and LEFT JOIN)

-- Ans
use ABC_Company;

CREATE TABLE Orders(order_id int primary key, order_date date, customer_id int );
INSERT INTO Orders(order_id, order_date, customer_id) values (1,"2024-01-01",101),(2,"2024-01-03",102);
select * from Orders;

CREATE TABLE Customers(customer_id int primary key, customer_name varchar(50));
INSERT INTO Customers(customer_id, customer_name) values (101,"Alice"),(102, "Bob");
select * from Customers;

CREATE TABLE Products(product_id int primary key, product_name varchar(50), order_id int );
INSERT INTO Products (product_id, product_name, order_id) values (1,"Laptop",1),(2,"Phone", Null);
select * from Products;

select Orders.order_id, Customers.customer_name, 
Products.product_name from Products 
LEFT JOIN (Orders inner join Customers 
on Orders.customer_id = Customers.customer_id)
on Products.order_id = Orders.order_id;

## Q.9  Given the following tables:
## (1) Sales (2) Products
## Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

-- ANS :- 
CREATE DATABASE XYZ_Company;
use XYZ_Company;

CREATE TABLE Sales(sale_id int primary key, product_id int, amount int);
INSERT INTO Sales(sale_id, product_id, amount)values(1,101,500),(2,102,300),(3,101,700);
select * from Sales;

CREATE TABLE Products(product_id int primary key, product_name varchar(50));
INSERT INTO Products(product_id, product_name) values (101,"Laptop"), (102,"Phone");
select * from Products;

select product_name, sum(amount) as total_sales from Sales inner join Products 
on Sales.product_id = Products.product_id 
group by product_name;

## Q.10 You are given three tables:
## (1) Orders (2) Customers (3) Order_Details
##  Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
## customer using an INNER JOIN between all three tables.

-- ANS :- 
use XYZ_Company;
 CREATE TABLE Orders(order_id int primary key, order_date date, customer_id int);
 insert into Orders(order_id, order_date, customer_id)values(1,"2024-01-02",1),(2,"2024-01-05",2);
 select * from Orders;
 
 CREATE TABLE Customers(customer_id int primary key, customer_name varchar(50));
 insert into Customers(customer_id,customer_name) values (1,"Alice"),(2,"Bob");
 select * from Customers;
 
 CREATE TABLE Order_Details(order_id int, product_id int , quantity int);
 insert into Order_Details(order_id, product_id,quantity) values (1,101,2),(1,102,1),(2,101,3);
 
 select Orders.order_id, Customers.customer_name,Order_Details.quantity 
 from Order_Details inner join (Orders inner join Customers on Orders.customer_id = Customers.customer_id)
 on Order_Details.order_id = Orders.order_id;

## SQL Commands
## Q.1 -Identify the primary keys and foreign keys in maven movies db. Discuss the differences.

-- ANS 
## Primary Keys in Maven Movies DB:- 
-- A Primary Key (PK) uniquely identifies each record in a table.
-- In Maven Movies DB, examples include:
-- actor >> actor_id
-- actor_award >> actor_award_id
-- address >> address_id
-- advisor >> advisor_id etc

## Foreign Keys in Maven Movies DB:-
-- A Foreign Key (FK) is a field in one table that refers to the Primary Key in another table, creating a relationship.
-- In Maven Movies DB, examples include:
-- actor_award >> actor_id
-- city>> country_id
-- inventory >> film_id
-- payment >> customer_id etc

## Differences between Primary Key and Foreign Key
-- Primary key :- Uniquely identifies each row in the table	
-- Cannot have NULL values	
-- Only one primary key per table	
-- Ensures entity integrity 

-- Foreign Key:- Refers to the primary key of another table
-- Can have NULL values
-- Can have multiple foreign keys in a table
-- Ensures referential integrity

## Q.2  2- List all details of actors
select * from actor;

## Q.3 List all customer information from DB
select * from customer;

## Q.4  List different countries.
use mavenmovies;
select distinct country_id, country from country;

##Q.5 -Display all active customers.
select customer_id, first_name,last_name, active from customer
where active = 1;

## Q.6 List of all rental IDs for customer with ID 1.
select customer_id , rental_id from rental
group by rental_id
having customer_id = 1;

## Q.7 Display all the films whose rental duration is greater than 5 .
select film_id, title,rental_duration from film
where rental_duration > 5
order by rental_duration;

##Q.8 List the total number of films whose replacement cost is greater than $15 and less than $20.
select count(*)as total_no_of_films 
from film
where replacement_cost > 15 and replacement_cost < 20;

##Q.9  Display the count of unique first names of actors.
select count(distinct first_name)as unique_fi_name_count from actor;

## Q.10 Display the first 10 records from the customer table.
select * from customer
order by customer_id 
limit 10;

##Q.11 - Display the first 3 records from the customer table whose first name starts with ‘b’
select * from customer
where first_name like 'b%'
order by customer_id
limit 3;

##Q.12 -Display the names of the first 5 movies which are rated as ‘G’
select film_id, title , rating from film
where rating = 'G'
order by film_id
limit 5;

##Q.13-Find all customers whose first name starts with "a"
select first_name from customer
where first_name like 'a%';

##Q.14  Find all customers whose first name ends with "a".
select first_name from customer
where first_name like '%a';

##Q.15  Display the list of first 4 cities which start and end with ‘a’.
select city_id, city from city
where city like 'a%'and city like '%a'
order by city_id
limit 4;

##Q.16  Find all customers whose first name have "NI" in any position.
use mavenmovies;
select customer_id, first_name from customer
where first_name like '%NI%';

##Q.17 Find all customers whose first name have "r" in the second position.
select customer_id, first_name from customer
where first_name like '_r%';

##Q.18  Find all customers whose first name starts with "a" and are at least 5 characters in length.
select  customer_id, first_name from customer
where first_name like 'a%'and length(first_name) >= 5;

##Q.19  Find all customers whose first name starts with "a" and ends with "o"
select customer_id, first_name from customer
where first_name like 'a%'and first_name like '%o';

##Q.20 - Get the films with pg and pg-13 rating using IN operator.
select film_id, title , rating from film
where rating in ("pg", "pg-13");

##Q.21 - Get the films with length between 50 to 100 using between operator.
select film_id, title, length from film
where length between 50 and 100
order by length;

##Q.22  Get the top 50 actors using limit operator.
select actor_id, first_name, last_name from actor
order by actor_id
limit 50;

##Q.23 Get the distinct film ids from inventory table.
use mavenmovies;
select distinct film_id from inventory;

## Functions:- Basic Aggregate Functions:

##Q.1  Retrieve the total number of rentals made in the Sakila database.
 ## Hint: Use the COUNT() function.
 use sakila;
 select  count(rental_id)as total_no_of_rental
 from rental;

##Q.2: Find the average rental duration (in days) of movies rented from the Sakila database.
 ## Hint: Utilize the AVG() function.
 select Avg(rental_duration) as Avg_rental_duration from film;
 
 ##Q.3  String Functions: Display the first name and last name of customers in uppercase.
 ## Hint: Use the UPPER () function.
 select upper(first_name) as FRIST_NAME , 
 upper(last_name)as LAST_NAME from customer;
 
 ##Q.4: Extract the month from the rental date and display it alongside the rental ID.
 ## Hint: Employ the MONTH() function.
 select rental_id, rental_date , MONTH(rental_date) as rental_month from rental;
 
 ##  GROUP BY:
 ##Q.5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 ## Hint: Use COUNT () in conjunction with GROUP BY.
 select customer_id, count(rental_id) as count_of_rentals 
 from rental
 group by customer_id;
 
 ##Q.6: Find the total revenue generated by each store.
 ## Hint: Combine SUM() and GROUP BY
 select store.store_id,sum(payment.amount) as total_revenue 
 from payment inner join (staff inner join store on
 staff.store_id = store.store_id) 
 on payment.staff_id = staff.staff_id
 group by store.store_id;
 
 
##Q.7: Determine the total number of rentals for each category of movies.
 ## Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
use sakila;
SELECT fc.category_id, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

##Q.8: Find the average rental rate of movies in each language.
 ## Hint: JOIN film and language tables, then use AVG () and GROUP BY
select language.language_id, language.name, 
avg(rental_rate)as avg_re_rate 
from language
left join  film on language.language_id = film.language_id
group by language.language_id
UNION
select language.language_id, language.name, 
avg(rental_rate)as avg_re_rate 
from language
right join  film on language.language_id = film.language_id
group by language.language_id;

## Joins
 ##Q.9 Display the title of the movie, customer s first name, and last name who rented it.
 ## Hint: Use JOIN between the film, inventory, rental, and customer tables.
use sakila;
 select film.title, customer.first_name, customer.last_name ,rental.rental_id,
 rental.customer_id from film inner join
 inventory on film.film_id = inventory.film_id inner join rental 
 on rental.inventory_id = inventory.inventory_id inner join customer 
 on customer.customer_id = rental.customer_id;
 
 ##  Q.10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 ## Hint: Use JOIN between the film actor, film, and actor tables.
 SELECT actor.first_name, actor.last_name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind';

##Q.11: Retrieve the customer names along with the total amount they've spent on rentals.
## Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
with my_cte as (select  customer_id, 
sum(amount) as total_amount
 from payment
group by customer_id
order by customer_id)
select customer.first_name, 
customer.last_name,
my_cte.total_amount 
from customer inner join my_cte 
on customer.customer_id = my_cte.customer_id;

## Q.12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
 ## Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT customer.first_name, 
       customer.last_name, 
       city.city AS city_name, 
       GROUP_CONCAT(DISTINCT film.title ORDER BY film.title) AS rented_movies
FROM customer
INNER JOIN address 
    ON customer.address_id = address.address_id
INNER JOIN city 
    ON address.city_id = city.city_id
INNER JOIN rental 
    ON customer.customer_id = rental.customer_id
INNER JOIN inventory 
    ON rental.inventory_id = inventory.inventory_id
INNER JOIN film 
    ON inventory.film_id = film.film_id
WHERE city.city = 'London'
GROUP BY customer.customer_id, customer.first_name, customer.last_name, city.city;

##  Advanced Joins and GROUP BY:
 ##Q.13: Display the top 5 rented movies along with the number of times they've been rented.
 ## Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

use sakila;
SELECT f.title AS movie_title, 
       COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 5;

## Q.14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
## Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
use sakila;
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
JOIN rental r 
    ON c.customer_id = r.customer_id
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

## Windows Function:
## Q. 1. Rank the customers based on the total amount they've spent on rentals.
with TA as
(select customer_id,sum(amount)
as total_amount 
from payment
group by customer_id)
select customer_id,
total_amount,
RANK()over(order by total_amount desc)
as rank_position 
from TA
order by rank_position;

## Q. 2. Calculate the cumulative revenue generated by each film over time.

use sakila;
SELECT 
    f.film_id,
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (
        PARTITION BY f.film_id 
        ORDER BY r.rental_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, r.rental_date;

##Q.3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    f.length,
    f.title,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.length, f.title
ORDER BY f.length, f.title;

##Q. 4. Identify the top 3 films in each category based on their rental counts.
WITH ranked_films AS (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (
            PARTITION BY c.name
            ORDER BY COUNT(r.rental_id) DESC
        ) AS rank_in_category
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
)
SELECT category_name, title, rental_count
FROM ranked_films
WHERE rank_in_category <= 3
ORDER BY category_name, rental_count DESC;

##Q.5. Calculate the difference in rental counts between each customer's total rentals 
## and the average rentals across all customers.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    (COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER ()) AS rental_diff_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_diff_from_avg DESC;

##Q. 6. Find the monthly revenue trend for the entire rental store over time.
SELECT 
    DATE_FORMAT(payment.payment_date, '%Y-%m') AS month,
    SUM(payment.amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment.payment_date, '%Y-%m')
ORDER BY month;

##Q.7Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spend_percent_rank
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, first_name, last_name, total_spent
FROM customer_spending
WHERE spend_percent_rank <= 0.2
ORDER BY total_spent DESC;

##Q.8Calculate the running total of rentals per category, ordered by rental count.
WITH category_rentals AS (
    SELECT 
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name
)
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (
        ORDER BY rental_count DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM category_rentals
ORDER BY rental_count DESC;

##Q.9Find the films that have been rented less than the average rental count for their respective categories.
WITH film_rentals AS (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
),
category_avg AS (
    SELECT 
        category_name,
        AVG(rental_count) AS avg_rentals
    FROM film_rentals
    GROUP BY category_name
)
SELECT 
    fr.category_name,
    fr.title,
    fr.rental_count,
    ca.avg_rentals
FROM film_rentals fr
JOIN category_avg ca 
    ON fr.category_name = ca.category_name
WHERE fr.rental_count < ca.avg_rentals
ORDER BY fr.category_name, fr.rental_count;

##Q.10Identify the top 5 months with the highest revenue and display the revenue generated in each month.
 SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY total_revenue DESC
LIMIT 5;

##Normalisation & CTE
##Q.1 First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. 
## Explain how you would normalize it to achieve 1NF.

-- ANS 1. Understanding 1NF
## First Normal Form (1NF) states that:
##1.Each column must contain atomic values (indivisible).
##2.There should be no repeating groups or arrays in a column.
##3.Each record must be unique

## 2. Table in Sakila that violates 1NF
## In the film table, the column special_features 
##contains comma-separated 
##values like:
## example:- Trailers,Deleted Scenes,Commentaries
## This violates 1NF because multiple values are 
##stored in a single cell — the values are not atomic.

## 3. How to normalize to achieve 1NF
## We break this multi-valued column into a separate 
##table where each row contains only 
## one special feature per film.

##4.Practical Normalization Steps:- 
use sakila;
-- Step 1: Create a new table for storing atomic special features
CREATE TABLE film_special_feature (
    film_id SMALLINT NOT NULL,
    special_feature VARCHAR(50) NOT NULL
);

-- Step 2: Insert atomic values for a film (example for film_id = 1)
INSERT INTO film_special_feature (film_id, special_feature)
VALUES
(1, 'Trailers'),
(1, 'Deleted Scenes'),
(1, 'Commentaries');

##5. Result after Normalization
select * from film_special_feature;
 
##Q.2. Second Normal Form (2NF): a. Choose a table in Sakila and describe 
## how you would determine whether it is in 2NF. 
## If it violates 2NF, explain the steps to normalize it.

-- ANS:-  Second Normal Form (2NF)
## Theory: A table is in 2NF if:
##1. It is already in 1NF (no repeating groups, atomic values).
##2.All non-prime attributes are fully dependent 
##on the entire primary key, not just a part of it

## 2NF Violation Example (Hypothetical table from Sakila):
##Suppose we create a table like this:
##example:-rental_details(rental_id, inventory_id, film_title, category_name)
##Primary Key: (rental_id, inventory_id)
##film_title and category_name depend only on inventory_id, not on full composite key → this violates 2NF

## Steps to Normalize to 2NF
##Step 1: Split the table to remove partial dependencies
## 1. Create inventory_film table:
use sakila;
CREATE TABLE inventory_film (
    inventory_id INT PRIMARY KEY,
    film_title VARCHAR(100),
    category_name VARCHAR(50));
    
## 2. Create clean rental_details table:
CREATE TABLE rental_details (
    rental_id INT,
    inventory_id INT,
    PRIMARY KEY (rental_id, inventory_id));

## Final Result
select * from inventory_film;
select * from rental_details;

## Q.3. Third Normal Form (3NF):a. Identify a table in Sakila that violates 3NF. 
##Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.

-- ANS:- Third Normal Form (3NF)
##Theory:A table is in 3NF if:
## 1.It is already in 2NF
## 2.It has no transitive dependencies, i.e., non-prime attributes should not depend on other non-prime attributes

## Example of 3NF Violation in Sakila (Hypothetical)
## Assume a table:-
## example:-customer_details(customer_id, first_name, last_name, address_id, city, country)
## Primary Key: customer_id
## city depends on address_id
## country depends on city
## So:
## customer_id → address_id → city → country
## This is a transitive dependency, violating 3NF

## Steps to Normalize to 3NF
## Step 1: Move transitive dependencies into separate tables
## Step 2: Create Normalized Tables
## 1.Create city_country table:
CREATE TABLE city_country (
    city VARCHAR(50) PRIMARY KEY,
    country VARCHAR(50));

## 2. Create address_city table:
CREATE TABLE address_city (
    address_id INT PRIMARY KEY,
    city VARCHAR(50));
    
## 3. Create final customer_details table:-
CREATE TABLE customer_details (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address_id INT);
    
## Final Result:
select * from city_country;
select * from address_city;
select * from customer_details;

##Q.4 Normalization Process a. Take a specific table in Sakila 
## and guide through the process of normalizing it from the initial  
## unnormalized form up to at least 2NF.

## Q.5. CTE Basics:
## a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
## have acted in from the actor and film_actor tables.
-- Step 1: Use CTE to join actor and film_actor
WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS total_films
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)

-- Step 2: Select from CTE
SELECT DISTINCT actor_name, total_films
FROM actor_film_count
ORDER BY total_films DESC;

## 6. CTE with Joins:
## a. Create a CTE that combines information from the film and language tables to display the film title, 
##language name, and rental rate.
-- Step 1: Create the CTE
WITH film_language_cte AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)

-- Step 2: Use the CTE
SELECT *
FROM film_language_cte
ORDER BY film_title;

##Q.7 CTE for Aggregation:
## a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
## from the customer and payment tables.
-- Step 1: Create the CTE to calculate total payments per customer
WITH customer_revenue AS (
    SELECT 
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM 
        payment p
    GROUP BY 
        p.customer_id
)

-- Step 2: Join with customer table to get names
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    cr.total_revenue
FROM 
    customer c
JOIN 
    customer_revenue cr ON c.customer_id = cr.customer_id
ORDER BY 
    cr.total_revenue DESC;
    
##Q.8 CTE with Window Functions:
## a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
-- Step 1: Create the CTE with a window function
WITH film_ranked AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM 
        film
)

-- Step 2: Select from the CTE
SELECT *
FROM film_ranked
ORDER BY duration_rank;

##Q.9 CTE and Filtering:
##a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
##customer table to retrieve additional customer details.
-- Step 1: CTE to count rentals per customer
WITH rental_count AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING 
        COUNT(rental_id) > 2
)

-- Step 2: Join with customer table for details
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    rc.total_rentals
FROM 
    rental_count rc
JOIN 
    customer c ON rc.customer_id = c.customer_id
ORDER BY 
    rc.total_rentals DESC;
    
##Q.10 CTE for Date Calculations:
## a. Write a query using a CTE to find the total number of rentals made each month, considering the 
## rental_date from the rental table

-- Step 1: Create the CTE to extract year and month, and count rentals
WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(*) AS total_rentals
    FROM 
        rental
    GROUP BY 
        DATE_FORMAT(rental_date, '%Y-%m')
)

-- Step 2: Select from the CTE
SELECT *
FROM monthly_rentals
ORDER BY rental_month;

##Q.11  CTE and Self-Join:
## a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
## together, using the film_actor table.

-- Step 1: Create a CTE for film_actor table
WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 
        ON fa1.film_id = fa2.film_id 
        AND fa1.actor_id < fa2.actor_id  -- avoid duplicates and self-pairing
)

-- Step 2: Join with actor table to get actor names
SELECT 
    ap.film_id,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name
FROM 
    actor_pairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY 
    ap.film_id, actor1_name, actor2_name;

##Q.12. CTE for Recursive Search:
## a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
## considering the reports_to column
-- CTE and Self-Join using real Sakila tables
WITH actor_pairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        a1.first_name AS actor1_first,
        a1.last_name AS actor1_last,
        fa2.actor_id AS actor2_id,
        a2.first_name AS actor2_first,
        a2.last_name AS actor2_last,
        fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id
    JOIN actor a1 ON fa1.actor_id = a1.actor_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
)

SELECT 
    actor1_first, actor1_last,
    actor2_first, actor2_last,
    film_id
FROM actor_pairs
ORDER BY film_id
LIMIT 20;
























