/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */

SELECT
    og_ranks.rank,
    og_ranks.title,
    og_ranks.revenue,
    sum(og_ranks.revenue) OVER (ORDER BY og_ranks.rank) AS "total revenue"
FROM (
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
    ORDER BY rank ASC, filtered_rev.title ASC
) as og_ranks
ORDER BY og_ranks.rank ASC, og_ranks.title ASC;
