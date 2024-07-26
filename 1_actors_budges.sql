-- 1 Select a list of actors along with the total budget of the movies they have appeared in
SELECT 
    p.person_id AS "ID",
    p.first_name AS "First name",
    p.last_name AS "Last name",
    COALESCE(SUM(m.budget), 0) AS "Total movies budget"
FROM person p
JOIN actor_roles ar ON p.person_id = ar.actor_id
JOIN character c ON ar.character_id = c.character_id
JOIN movie m ON c.movie_id = m.movie_id
GROUP BY p.person_id, p.first_name, p.last_name;


