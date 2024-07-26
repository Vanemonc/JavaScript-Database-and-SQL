-- Table: user
CREATE TABLE "user_account" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    avatar_id INT REFERENCES "file"(file_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: file

CREATE TABLE "file" (
    file_id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    key VARCHAR(255) NOT NULL,
    public_url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Table: movie
CREATE TABLE "movie" (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL,
    release_date DATE,
    duration INTERVAL,
    director_id INT REFERENCES person(person_id),
    country_id INT REFERENCES country(country_id),
    poster_file_id INT REFERENCES "file"(file_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE movie
ALTER COLUMN budget TYPE DECIMAL(15, 2) USING budget::DECIMAL(15, 2);

-- Table: genre
CREATE TABLE "genre" (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE "movie_genre" (
    movie_id INT REFERENCES movie(movie_id),
    genre_id INT REFERENCES genre(genre_id),
    PRIMARY KEY (movie_id, genre_id)
);
-- Table: character
CREATE TABLE "character" (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role VARCHAR(20) CHECK (role IN ('leading', 'supporting', 'background')),
    movie_id INT REFERENCES movie(movie_id),
    actor_id INT REFERENCES person(person_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE gender_enum AS ENUM ('Male', 'Female', 'Other');

-- Table: person
CREATE TABLE "person" (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    biography TEXT,
    birth_date DATE,
    gender gender_enum,
    country_id INT REFERENCES country(country_id),
    photo_id INT REFERENCES "file"(file_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: person_photos
CREATE TABLE person_photos (
    photo_id SERIAL PRIMARY KEY,
    person_id INTEGER,
    file_id INTEGER,
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (file_id) REFERENCES "file"(file_id)
);


-- Table: actor_role
CREATE TABLE actor_roles (
    actor_id INTEGER,
    character_id INTEGER,
    PRIMARY KEY (actor_id, character_id),
    FOREIGN KEY (actor_id) REFERENCES person(person_id),
    FOREIGN KEY (character_id) REFERENCES character(character_id)
);

DROP TABLE IF EXISTS favorite_movies;

-- Table: favorite_movies
CREATE TABLE favorite_movies (
    user_id INT REFERENCES "user_account"(user_id),
    movie_id INT REFERENCES movie(movie_id),
    PRIMARY KEY (user_id, movie_id)
);

-- Table: country
CREATE TABLE country (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


