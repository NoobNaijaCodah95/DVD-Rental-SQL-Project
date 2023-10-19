WITH staff_revenue as (
SELECT  staff_id, SUM(amount) AS staff_total
FROM payment
GROUP BY staff_id
ORDER BY staff_id DESC)

SELECT *,
DENSE_RANK() OVER (ORDER BY staff_total DESC) AS rank
FROM staff_revenue
