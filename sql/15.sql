/*
 * Compute the total revenue for each film.
 */

SELECT film.title,COALESCE(revs.revenue,0.00) as revenue 
FROM film
LEFT JOIN (
    SELECT film.title, SUM(payment.amount) as revenue
    FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    JOIN payment USING(rental_id)
    GROUP BY film.title
) as revs ON  revs.title = film.title
ORDER BY revenue DESC, film.title ASC;
