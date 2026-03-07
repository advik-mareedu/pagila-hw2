/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

SELECT DISTINCT actor.first_name || ' ' || actor.last_name as "Actor Name"
FROM actor
LEFT JOIN (
    SELECT unnest(special_features) as special_feat, first_name, last_name
    FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
) as spec_feat ON spec_feat.first_name = actor.first_name
                  AND spec_feat.last_name = actor.last_name
WHERE spec_feat.special_feat = 'Behind the Scenes'
      AND spec_feat.first_name IS NOT NULL
ORDER BY "Actor Name";
