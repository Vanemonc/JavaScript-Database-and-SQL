-- Select detailed information about movies that meet specific criteria

SELECT 
    m.movie_id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration AS "Duration",
    m.description AS "Description",
    json_build_object(
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'public_url', f.public_url
    ) AS "Poster",
    json_build_object(
        'ID', p.person_id,
        'First name', p.first_name,
        'Last name', p.last_name
    ) AS "Director"
FROM movie m
JOIN file f ON m.poster_file_id = f.file_id
JOIN person p ON m.director_id = p.person_id
JOIN movie_genre mg ON m.movie_id = mg.movie_id
JOIN genre g ON mg.genre_id = g.genre_id
WHERE m.country_id = 1
  AND m.release_date >= '2022-01-01'
  AND m.duration > INTERVAL '2 hours 15 minutes'
  AND g.genre_name IN ('Action', 'Drama');













