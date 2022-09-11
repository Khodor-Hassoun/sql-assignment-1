SELECT movies.name, movies.earnings_rank
FROM movies
JOIN oscars
ON movies.id = oscars.movie_id
WHERE oscars.type = 'Best-Picture'
ORDER BY movies.earnings_rank
LIMIT 1;