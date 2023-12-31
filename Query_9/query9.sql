-- Rank each rental by the rental date and ensure the customer_id is grouped as well.

SELECT rental_id, customer_id, rental_date, 
       RANK() OVER (PARTITION BY customer_id ORDER BY rental_date) as rental_rank
FROM rental;
