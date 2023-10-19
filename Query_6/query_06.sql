-- Customers Full Names where at least one payment is greater than 11.

SELECT first_name, last_name
FROM customer as c
WHERE EXISTS
(SELECT * FROM payment as p
WHERE p.customer_id = c.customer_id
AND amount > 11)
