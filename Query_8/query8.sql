-- Display the full name of customers in one column that purchased in store_id '2' AND first name starts with S.
SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer
WHERE store_id = 2
AND first_name ILIKE 's%'

