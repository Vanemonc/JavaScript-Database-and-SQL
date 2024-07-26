-- Select directors along with the average budget of the movies they have directed

SELECT 
    p.person_id AS "Director ID",
    CONCAT(p.first_name, ' ', p.last_name) AS "Director name",
    ROUND(AVG(m.budget), 2) AS "Average budget"
FROM person p
JOIN movie m ON p.person_id = m.director_id
GROUP BY p.person_id, p.first_name, p.last_name;







