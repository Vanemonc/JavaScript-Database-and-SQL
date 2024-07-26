--Select detailed information about a movie with ID of 1

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
    ) AS "Director",
    json_build_object(
        'ID', pp.photo_id,
        'file_name', pf.file_name,
        'mime_type', pf.mime_type,
        'key', pf.key,
        'public_url', pf.public_url
    ) AS "Photo",
    json_agg(
        json_build_object(
            'ID', a.person_id,
            'First name', a.first_name,
            'Last name', a.last_name,
            'Photo', json_build_object(
                'file_name', af.file_name,
                'mime_type', af.mime_type,
                'key', af.key,
                'public_url', af.public_url
            )
        )
    ) AS "Actors",
    json_agg(
        json_build_object(
            'ID', g.genre_id,
            'Name', g.genre_name
        )
    ) AS "Genres"
FROM movie m
LEFT JOIN file f ON m.poster_file_id = f.file_id
LEFT JOIN person p ON m.director_id = p.person_id
LEFT JOIN person_photos pp ON p.person_id = pp.person_id
LEFT JOIN file pf ON pp.file_id = pf.file_id
LEFT JOIN character c ON m.movie_id = c.movie_id
LEFT JOIN actor_roles ar ON c.character_id = ar.character_id
LEFT JOIN person a ON ar.actor_id = a.person_id
LEFT JOIN file af ON a.photo_id = af.file_id
LEFT JOIN movie_genre mg ON m.movie_id = mg.movie_id
LEFT JOIN genre g ON mg.genre_id = g.genre_id
WHERE m.movie_id = 1
GROUP BY m.movie_id, f.file_name, f.mime_type, f.key, f.public_url, p.person_id, p.first_name, p.last_name, pp.photo_id, pf.file_name, pf.mime_type, pf.key, pf.public_url;














