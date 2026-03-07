/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT DISTINCT film.title
FROM inventory
LEFT JOIN film ON inventory.film_id = film.film_id
LEFT JOIN (
    SELECT title
    FROM film
    JOIN inventory USING(film_id)
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING (country_id)
    WHERE country.country = 'United States'
) as us_films
ON us_films.title = film.title
WHERE us_films.title IS NULL
ORDER BY title ASC;
