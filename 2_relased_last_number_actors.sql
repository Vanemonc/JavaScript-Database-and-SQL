-- Select movies released in the last 5 years with the number of actors who have appeared in each movie

SELECT 
    m.movie_id AS "ID",
    m.title AS "Title",
    COUNT(DISTINCT ar.actor_id) AS "Actors count"
FROM movie m
LEFT JOIN character c ON m.movie_id = c.movie_id
LEFT JOIN actor_roles ar ON c.character_id = ar.character_id
WHERE m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY m.movie_id, m.title;


