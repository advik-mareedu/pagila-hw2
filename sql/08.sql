/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */

SELECT trailers.title
FROM film
LEFT JOIN (
    SELECT title,unnest(special_features) as feat
    FROM film
) as trailers
ON film.title = trailers.title
WHERE film.rating = 'G' 
    AND trailers.title IS NOT NULL
    AND trailers.feat = 'Trailers'
ORDER BY film.title ASC;
