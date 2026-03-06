/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */

SELECT DISTINCT title
FROM inventory
JOIN film USING (film_id)
WHERE title NOT IN (
    SELECT DISTINCT title
    FROM country
    JOIN city USING(country_id)
    JOIN address USING (city_id)
    JOIN customer USING (address_id)
    JOIN rental USING (customer_id)
    JOIN inventory USING (inventory_id)
    JOIN film USING(film_id)
    WHERE country.country = 'United States'
)
ORDER BY title ASC;

