# 🎥 DVD-Rental-SQL-Project 🎥
For this project we are using a DVD rental database for analysis. 

To start here is the DVD Rental ER Model (Simplified version for a general overview)
![image](https://github.com/NoobNaijaCodah95/DVD-Rental-SQL-Project/assets/137308988/6876eb6b-8330-469d-93f2-f94dd4703703)

- Database Name : DVD Rental
- SQL Version Used : PostgreSQL

There are 15 tables in the DVD Rental database:

- actor – stores actors data including first name and last name.
- film – stores film data such as title, release year, length, rating, etc.
- film_actor – stores the relationships between films and actors.
- category – stores film’s categories data.
- film_category- stores the relationships between films and categories.
- store – contains the store data including manager staff and address.
- inventory – stores inventory data.
- rental – stores rental data.
- payment – stores customer’s payments.
- staff – stores staff data.
- customer – stores customer data.
- address – stores address data for staff and customers
- city – stores city names.
- country – stores country names.

LIST OF QUERIES
- Query 1
-- the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
`SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount), email
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10`
- Query 2
-- Get a list of all the movies with the actor "Nick Wahlberg" in it
`SELECT title, first_name, last_name
FROM film_actor 
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick'
AND last_name = 'Wahlberg'`
- Query 3
-- Create a query that lists each film category and the number of films made in that category
`SELECT DISTINCT category_name,
COUNT(film_title) OVER(PARTITION BY  category_name) AS category_count
FROM
	(SELECT f.title film_title, c.name category_name
	FROM film f 
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id) t1
ORDER BY category_count DESC`
- Query 4
-- 4. Select film titles where the rental rate is greater than the average.
`SELECT title, rental_rate 
FROM film
WHERE rental_rate >
(SELECT AVG(rental_rate) FROM film)`
- Query 5
-- Find the film id's and titles that have been returned between '2005-05-29' AND '2005-05-30'.

`SELECT film_id, title 
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental 
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY film_id`
- Query 6
-- Customers Full Names where at least one payment is greater than 11.
`SELECT first_name, last_name
FROM customer as c
WHERE EXISTS
(SELECT * FROM payment as p
WHERE p.customer_id = c.customer_id
AND amount > 11)`
- Query 7
-- Which staff member generated the most revenue

`WITH staff_revenue as (
SELECT  staff_id, SUM(amount) AS staff_total
FROM payment
GROUP BY staff_id
ORDER BY staff_id DESC)
SELECT *,
DENSE_RANK() OVER (ORDER BY staff_total DESC) AS rank
FROM staff_revenue`

- Query 8
-- Display the full name of customers in one column that purchased in store_id '2' AND first name starts with S.
`SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer
WHERE store_id = 2
AND first_name ILIKE 's%'`
- Query 9
-- Rank each rental by the rental date and ensure the customer_id is grouped as well.
`SELECT rental_id, customer_id, rental_date, 
RANK() OVER (PARTITION BY customer_id ORDER BY rental_date) as rental_rank
FROM rental;`
- Query 10
-- Find the 10 Most profitable customers with their emails.

`SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount), email
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10`
