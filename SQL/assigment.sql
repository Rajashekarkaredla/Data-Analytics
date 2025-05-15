CREATE TABLE Users (
user_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
signup_date DATE,
country VARCHAR(50)
);
INSERT INTO Users VALUES
(1, 'Alice Smith', 'alice@example.com', '2023-02-15', 'USA'),
(2, 'Bob Johnson', 'bob@example.com', '2023-03-10', 'Canada'),
(3, 'Charlie Lee', 'charlie@example.com', '2022-11-05', 'UK'),
(4, 'Diana Patel', 'diana@example.com', '2021-07-22', 'India'),
(5, 'Ethan Brown', 'ethan@example.com', '2024-01-30', 'USA');

--MOVIES TABLE
CREATE TABLE Movies (
movie_id INT PRIMARY KEY,
title VARCHAR(100),
genre VARCHAR(50),
release_year INT,
rating DECIMAL(2,1)
);
INSERT INTO Movies VALUES
(1, 'The Action Hero', 'Action', 2018, 4.2),
(2, 'Romantic Nights', 'Romance', 2020, 3.8),
(3, 'Thrill Seeker', 'Thriller', 2019, 4.5),
(4, 'Drama Unfolds', 'Drama', 2021, 4.0),
(5, 'Comedy Hour', 'Comedy', 2023, 3.9);

-- ViewingHistory Table
CREATE TABLE ViewingHistory (
view_id INT PRIMARY KEY,
user_id INT,
movie_id INT,
watch_date DATE,
watch_duration INT
);
INSERT INTO ViewingHistory VALUES
(1, 1, 1, '2023-04-01', 120),
(2, 1, 3, '2023-04-05', 110),
(3, 2, 2, '2023-04-10', 95),
(4, 2, 1, '2023-04-12', 100),
(5, 3, 4, '2023-04-15', 130),
(6, 4, 5, '2023-04-20', 90),
(7, 5, 1, '2023-04-22', 125);

-- Reviews Table
CREATE TABLE Reviews (
review_id INT PRIMARY KEY,
user_id INT,
movie_id INT,
rating INT,
review_text TEXT,
review_date DATE
);
INSERT INTO Reviews VALUES
(1, 1, 1, 5, 'Loved the action!', '2023-04-02'),
(2, 2, 2, 4, 'Sweet and emotional.', '2023-04-11'),
(3, 3, 4, 3, 'Good drama, slow start.', '2023-04-16'),
(4, 4, 5, 5, 'Hilarious!', '2023-04-21'),
(5, 5, 1, 4, 'Great fun!', '2023-04-23');

--List all movies released after 2015.
SELECT title FROM movies WHERE release_year > 2015;

--List all users from the USA who signed up after January 1, 2023.
SELECT DISTINCT country FROM users WHERE signup_date >'2023-1-1';

--Find all movies in the 'Drama' or 'Thriller' genres.
SELECT title FROM movies WHERE genre = 'Drama' or genre='Thriller';

--Show the top 10 most recent reviews.
SELECT m.title 
FROM movies m
JOIN Reviews r ON r.movie_id = m.movie_id
ORDER BY review_date DESC;

--Find users who have never written a review
SELECT u.name
FROM users u 
LEFT JOIN Reviews r ON r.user_id=u.user_id
WHERE r.review_id IS NULL;

--For each user, show how many movies they have watched.
SELECT u.user_id,u.name, COUNT(v.movie_id) AS movies_watched
FROM users u 
LEFT JOIN ViewingHistory v ON u.user_id = v.user_id
GROUP BY u.user_id,u.name

--For each movie, show the total number of unique viewers.
SELECT m.title ,COUNT(DISTINCT v.user_id) AS viewers
FROM movies m
LEFT JOIN ViewingHistory v ON m.movie_id = v.movie_id
GROUP BY m.title;

--For each genre, find the average rating across all movies.
SELECT genre, ROUND(AVG(rating),1) AS avg_rating
FROM movies
GROUP BY genre;

--movies with no rating
SELECT m.title 
FROM movies m
LEFT JOIN Reviews r ON r.movie_id=m.movie_id
WHERE r.rating IS NULL;

-- For each user, find the total minutes they have watched.
SELECT u.name, SUM(v.watch_duration) AS duration
FROM users u 
LEFT JOIN ViewingHistory v ON v.user_id=u.user_id
GROUP BY u.name

--Find users who have watched more than 2 movies.
SELECT u.name, COUNT(v.user_id) AS watched
FROM users u 
 LEFT JOIN ViewingHistory v ON v.user_id=u.user_id
 GROUP BY u.name
 HAVING COUNT(v.user_id)>=2;

--List movies that have received at least 2 reviews but an average rating below 5
SELECT m.title, COUNT(r.movie_id), ROUND(AVG(r.rating),1)
FROM movies m 
LEFT JOIN Reviews r ON r.movie_id=m.movie_id
GROUP BY m.title
HAVING COUNT(r.movie_id)>=2 AND AVG(r.rating)<5;

-- Find the average number of minutes watched per user, grouped by country
SELECT u.country , ROUND(AVG(v.watch_duration),1) AS watched
FROM users u
LEFT JOIN ViewingHistory v ON v.user_id = u.user_id
GROUP BY country;

-- For each year, find the number of movies released.
SELECT release_year, COUNT(movie_id) AS released
FROM Movies
GROUP BY release_year;
