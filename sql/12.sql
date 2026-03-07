/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT bts.title
FROM (
    SELECT title
    FROM film, unnest(special_features) as spec_feat
    WHERE 'Behind the Scenes' = spec_feat
) as bts
JOIN (
    SELECT title
    FROM film, unnest(special_features) as spec_feat
    WHERE 'Trailers' = spec_feat
) as trailers
ON bts.title = trailers.title
ORDER BY bts.title;


