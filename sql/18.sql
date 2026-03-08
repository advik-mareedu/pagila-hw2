/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

SELECT 
    new_ranks.rank,
    new_ranks.title,
    new_ranks.revenue,
    new_ranks."total revenue",
    TO_CHAR(new_ranks."total revenue"*100 /SUM(new_ranks.revenue) OVER () ,'FM900.00') as "percent revenue"
FROM (
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
    ORDER BY og_ranks.rank ASC, og_ranks.title ASC
) as new_ranks
ORDER BY new_ranks.rank ASC, new_ranks.title ASC;
