SELECT SUBSTR ('this string',6);

SELECT released,
SUBSTR(released, 1, 4) AS year,
SUBSTR(released, 6, 2) AS month,
SUBSTR(released,9,2) AS day
FROM album
ORDER BY released
;

SELECT a.title AS Album, COUNT(t.track_number) as Tracks
  FROM track AS t
  JOIN album AS a
    ON a.id = t.album_id
  WHERE a.artist='The Beatles'
  GROUP BY a.id
  HAVING Tracks>=10
  ORDER BY Tracks DESC, Album
;

SELECT * FROM album WHERE id IN(
SELECT DISTINCT album_id FROM track WHERE duration <=90
);

SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
  FROM album AS a
  JOIN track AS t
    ON t.album_id = a.id
  WHERE a.id IN (SELECT DISTINCT album_id FROM track WHERE duration <= 90)
  ORDER BY a.title, t.track_number
;

SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
  FROM album AS a
  JOIN (
    SELECT album_id, track_number, duration, title
      FROM track
      WHERE duration <= 90
  ) AS t
    ON t.album_id = a.id
  ORDER BY a.title, t.track_number
;

CREATE VIEW trackView AS 
SELECT id, album_id, title, track_number, duration/60 AS m, duration% 60 AS s FROM track;
SELECT * FROM trackView;

SELECT a.title AS album, a.artist, t.track_number AS seq, t.track_number AS seq, t.title, t.m, t.s
FROM album AS a
JOIN trackView as t
ON t.album_id=a.id 
ORDER BY a.title, t.track_number;

CREATE VIEW joinedAlbum AS
SELECT a.artist AS artist,
    a.title AS album,
    t.title AS track,
    t.track_number AS trackno,
    t.duration / 60 AS m,
    t.duration % 60 AS s
  FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
;
SELECT * FROM joinedAlbum;

SELECT artist, album, track, trackno, 
    m || ':' || CASE WHEN s < 10 THEN '0' || s ELSE s END AS duration
    FROM joinedAlbum;
