-- Find the 10 Most profitable customers with their emails. 

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount), email
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10
