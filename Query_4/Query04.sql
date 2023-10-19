-- 4. Select film titles where the rental rate is greater than the average.

SELECT title, rental_rate 
FROM film
WHERE rental_rate >
(SELECT AVG(rental_rate) FROM film)
