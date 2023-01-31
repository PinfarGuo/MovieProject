-- Movies based on actors I like: Donnie Yen, Jackie Chan, Bruce Willis, Adam Sandler, Robert Downey Jr., Chris Pratt, Vin Diesel, Jason Momoa, Johnny Depp, Keanu Reeves, Tom Cruise
-- Movies based on movie names: 
-- Movies based on genres: Action, Adventure, Animation
-- Movies based on company: Marvel Studios, Walt Disney Pictures, Warner Bros., DreamWorks Animation, Twentieth Century Fox Animation, Paramount Pictures, Pixar Animation Studios, Columbia Pictures, Universal Pictures
-- Movies based on directors: 

SELECT *
FROM MoviesProject..movies$
;


SELECT gross, star, company, director, writer, name, genre, year
FROM MoviesProject..movies$
WHERE gross >100000000
ORDER BY gross DESC
;


--- queries based on stars
SELECT TOP 100 star, SUM(gross) AS GrossSum
FROM MoviesProject..movies$
GROUP BY star
ORDER BY GrossSum DESC
;
-- list of movies by the TOP 10 stars
SELECT star, gross, name, genre, year
FROM MoviesProject..movies$
WHERE star IN ('Robert Downey Jr.','Tom Cruise','Will Smith','Johnny Depp','Vin Diesel','Dwayne Johnson','Bruce Willis',
				'Adam Sandler','Brad Pitt','Channing Tatum','Chris Hemsworth','Chris Pratt','Denzel Washington','Donnie Yen',
				'Jackie Chan','Julia Roberts','Keanu Reeves','Liam Neeson','Mark Wahlberg','Matt Damon','Ryan Reynolds')
ORDER BY star, year DESC, gross DESC
;
-- COUNT of genres for pie chart
SELECT star, genre, COUNT(genre) AS genreCount
FROM MoviesProject..movies$
WHERE star IN ('Robert Downey Jr.','Tom Cruise','Will Smith','Johnny Depp','Vin Diesel','Dwayne Johnson','Bruce Willis',
				'Adam Sandler','Brad Pitt','Channing Tatum','Chris Hemsworth','Chris Pratt','Denzel Washington','Donnie Yen',
				'Jackie Chan','Julia Roberts','Keanu Reeves','Liam Neeson','Mark Wahlberg','Matt Damon','Ryan Reynolds')
GROUP BY star, genre
ORDER BY star
;


--- queries based on directors via Temp Table
DROP TABLE IF EXISTS #temp_DirectorGrossSum
CREATE TABLE #temp_DirectorGrossSum(
director nvarchar(255),
grossSum float
);
INSERT INTO #temp_DirectorGrossSum
SELECT director, SUM(gross) AS GrossSum
FROM MoviesProject..movies$
GROUP BY director
ORDER BY GrossSum DESC
;
-- list of movies by the TOP 10 directors
SELECT director, gross, name, genre, year
FROM MoviesProject..movies$
WHERE director IN (SELECT TOP 10 director
					FROM #temp_DirectorGrossSum
					ORDER BY grossSum DESC
					)
ORDER BY director, year DESC, gross DESC
;
-- COUNT of genres for pie chart
SELECT director, genre, COUNT(genre) AS genreCount
FROM MoviesProject..movies$
WHERE director IN (SELECT TOP 10 director
					FROM #temp_DirectorGrossSum
					ORDER BY grossSum DESC
					)
GROUP BY director, genre
ORDER BY director
;


--- queries based on company
SELECT TOP 10 company, SUM(gross) AS GrossSum
FROM MoviesProject..movies$
GROUP BY company
ORDER BY GrossSum DESC
;
-- list of movies by the TOP 10 company
SELECT company, gross, name, genre, year
FROM MoviesProject..movies$
WHERE company IN ('Warner Bros.','Universal Pictures','Columbia Pictures','Paramount Pictures','Twentieth Century Fox',
					'Walt Disney Pictures','New Line Cinema','Marvel Studios','DreamWorks Animation','Touchstone Pictures')
ORDER BY company, year DESC, gross DESC
;
-- COUNT of genres for pie chart
SELECT company, genre, COUNT(genre) AS genreCount
FROM MoviesProject..movies$
WHERE company IN ('Warner Bros.','Universal Pictures','Columbia Pictures','Paramount Pictures','Twentieth Century Fox',
					'Walt Disney Pictures','New Line Cinema','Marvel Studios','DreamWorks Animation','Touchstone Pictures')
GROUP BY company, genre
ORDER BY company
;