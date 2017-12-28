SELECT Name, LifeExpectancy AS 'Life Expectancy' FROM Country ORDER BY Name;

SELECT Name, Continent, Region FROM Country WHERE Continent = 'Europe' LIMIT 5;

SELECT Name AS 'Country',Code AS 'ISO', Region, Population FROM Country ORDER BY Code LIMIT 5;

SELECT COUNT (*) FROM Country WHERE Population >100000000 AND Continent='Europe';

SELECT Name, Continent, Population FROM Country WHERE Population < 100000 OR Population IS NULL ORDER BY Population DESC;


SELECT Name, Continent, Population FROM Country WHERE Name LIKE '%island%' ORDER BY Name;


SELECT Name, Continent, Population FROM Country WHERE Name LIKE '_l%' ORDER BY Name;


SELECT Name, Continent, Population FROM Country WHERE Continent IN ('Europe', 'Asia') ORDER BY Name;

SELECT DISTINCT Continent FROM Country;

SELECT Name, Continent, Region FROM Country ORDER BY Continent DESC, Region, Name;

CREATE TABLE booltest (a INTEGER, b INTEGER);
INSERT INTO booltest VALUES (1, 0);
SELECT * FROM booltest;

SELECT
    CASE WHEN a THEN 'true' ELSE 'false' END as boolA,
    CASE WHEN b THEN 'true' ELSE 'false' END as boolB
    FROM booltest
;

SELECT
  CASE a WHEN 1 THEN 'true' ELSE 'false' END AS boolA,
  CASE b WHEN 1 THEN 'true' ELSE 'false' END AS boolB 
  FROM booltest
;

DROP TABLE booltest;

SELECT Name, LENGTH(Name) AS Len FROM City ORDER BY Len DESC, Name;

SELECT Region, COUNT(*) AS Count
FROM Country
GROUP BY Region
ORDER BY Count DESC, Region
;
SELECT co.Name, ss.CCode FROM(

SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode, SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t
) AS ss
JOIN Country AS co On co.Code2=ss.Country;
SELECT Region, SUM(Population) FROM Country GROUP BY Region;