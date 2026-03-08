/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

SELECT 
    RANK() OVER (ORDER BY filtered_rev.revenue DESC) as rank,
    filtered_rev.title,
    filtered_rev.revenue
FROM (
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
) as filtered_rev
ORDER BY rank ASC, filtered_rev.title ASC; 
