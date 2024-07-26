
-- Retrieve a list of all users along with their favorite movies as an array of identifiers

SELECT 
    u.user_id AS "ID",
    u.username AS "Username",
    ARRAY_AGG(fm.movie_id) AS "Favorite movie IDs"
FROM user_account u
LEFT JOIN favorite_movies fm ON u.user_id = fm.user_id
GROUP BY u.user_id, u.username;





