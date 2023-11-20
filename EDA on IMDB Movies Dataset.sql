/* Inspecting the data frame */
SELECT * 
FROM MovieRating..movie

/* Looking for any null values*/
SELECT *
FROM MovieRating..movie
WHERE Certificate IS NULL 
AND Meta_score IS NULL 

/* Remove Null Values from dataset */
DELETE FROM MovieRating..movie
WHERE Certificate IS NULL or 
Meta_score IS NULL

DELETE FROM MovieRating..movie
WHERE Gross IS NULL
---- Nulls Values Removed Succesfully-----

 /* Looking for any duplicates rows */
SELECT *, ROW_NUMBER() OVER (PARTITION BY Movies_Title ORDER BY Released_Year DESC)
FROM MovieRating..movie
----- No Null Values Found------

/* Change dtype for Runtime Column into a new column as integer */
ALTER TABLE MovieRating..movie
ADD New_runtime int
	UPDATE MovieRating..movie
	SET New_runtime = SUBSTRING(Runtime,1,3)

/* Remove unused Colums from the dataset  */
ALTER TABLE MovieRating..movie
	DROP COLUMN Poster_Link, Overview, Runtime

/* Update Values in Certificate Column */
UPDATE MovieRating..movie
SET Certificate = 'UA'
WHERE Certificate = 'U/A'

UPDATE MovieRating..movie
SET Certificate = 'TV-PG'
WHERE Certificate = 'PG'

UPDATE MovieRating..movie
SET Certificate = 'GP'
WHERE Certificate = 'G'


/* SEPARATE GENRE INTO COLUMNS */
 SELECT Genre,
 REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 1)) AS Genre1,
 REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 2)) AS Genre2,
 REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 3)) AS Genre3
FROM MovieRating..movie

ALTER TABLE MovieRating..movie
ADD Genre1 nvarchar(225);
		UPDATE MovieRating..movie
		SET Genre1 = REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 1))

ALTER TABLE MovieRating..movie
ADD Genre2 nvarchar(225);
		UPDATE MovieRating..movie
		SET Genre2 = REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 2))

ALTER TABLE MovieRating..movie
ADD Genre3 nvarchar(225);
		UPDATE MovieRating..movie
		SET Genre3 = REVERSE(PARSENAME(REPLACE(REVERSE(Genre), ',', '.'), 3))

/* Inspecting Data */ 
SELECT * 
FROM MovieRating..movie
