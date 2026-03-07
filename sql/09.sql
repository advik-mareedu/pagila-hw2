/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */

SELECT special.special_features, COUNT(*)
FROM (
    SELECT title, unnest(special_features) as special_features
    FROM film
) as special
GROUP BY special.special_features
ORDER BY special.special_features ASC;
