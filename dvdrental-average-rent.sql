SELECT
   f.film_id,
   f.title,
   ROUND(AVG(DATE_PART('day', r.return_date - r.rental_date))) AS average_rental_duration_days
FROM
   film f
JOIN
   inventory i ON f.film_id = i.film_id
JOIN
   rental r ON i.inventory_id = r.inventory_id
WHERE
   r.return_date IS NOT NULL
GROUP BY
   f.film_id, f.title
ORDER BY
   average_rental_duration_days DESC;