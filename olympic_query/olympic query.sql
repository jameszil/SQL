
-- source: https://github.com/bbrumm/databasestar/tree/main/sample_databases/sample_db_olympics/mysql

SELECT city.city_name, games.games_year, games.games_name
FROM olympics.city, olympics.games;

SELECT medal.medal_name, noc_region.region_name, sport.sport_name, games.games_year, person.full_name
FROM olympics.medal, olympics.noc_region, olympics.sport, olympics.games, olympics.person
WHERE sport.sport_name = 'Curling' AND medal.medal_name = 'Gold' AND games.games_year > 2000
ORDER BY medal.medal_name DESC;

-- TO DO DISTINCT COUNT
SELECT DISTINCT person.full_name, COUNT(person.full_name)
FROM olympics.person
GROUP BY person.full_name;

SELECT DISTINCT medal.medal_name, COUNT(medal.medal_name)
FROM olympics.medal
GROUP BY medal.medal_name;

-- GROUP BY USE CASE -- TO DO
SELECT medal.medal_name, noc_region.region_name, sport.sport_name, games.games_year
FROM olympics.medal, olympics.noc_region, olympics.sport, olympics.games, olympics.person
GROUP BY noc_region.region_name;

-- JOIN USE CASE
SELECT *
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev ON med.id = compev.medal_id;

SELECT *
FROM games_competitor AS GC
JOIN olympics.competitor_event AS compev ON GC.id = compev.event_id;

SELECT *
FROM games_competitor AS GC
JOIN olympics.competitor_event AS compev ON GC.id = compev.event_id;


-- MULTIPLE JOIN USE CASE
SELECT *
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id;


SELECT *
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id
JOIN olympics.person AS pers
ON GC.person_id = pers.id
JOIN olympics.person_region AS persreg
ON pers.id = persreg.person_id
JOIN olympics.noc_region AS nocreg
ON persreg.region_id = nocreg.id
JOIN olympics.games as gam
ON GC.games_id = gam.id;

-- Wrapped Query / SubQuery
SELECT DISTINCT medal.medal_name, COUNT(medal.medal_name)
FROM olympics.medal
GROUP BY medal.medal_name;

SELECT DISTINCT Wrapped.medal_name, COUNT(Wrapped.medal_name)
FROM
(SELECT *
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id)
AS Wrapped
GROUP BY Wrapped.medal_name;
-- fix^^^


-- Wrapped Query / SubQuery #2
SELECT Wrapped.age, wrapped.medal_name
FROM
(SELECT medal_name, event_id, competitor_id, games_id, person_id, age
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id)
AS Wrapped;

-- Wrapped Query / SubQuery #3
SELECT DISTINCT Wrapped.medal_name, COUNT(Wrapped.medal_name)
FROM
(SELECT medal_name, event_id, competitor_id, games_id, person_id, age
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id)
AS Wrapped
WHERE Wrapped.medal_name NOT LIKE '%NA%'
GROUP BY Wrapped.medal_name;


SELECT DISTINCT Wrapped.medal_name, COUNT(Wrapped.medal_name)
FROM
(SELECT medal_name, age, full_name, gender, height, weight, noc, region_name
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev
ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC
ON GC.id = compev.competitor_id
JOIN olympics.person AS pers
ON GC.person_id = pers.id
JOIN olympics.person_region AS persreg
ON pers.id = persreg.person_id
JOIN olympics.noc_region AS nocreg
ON persreg.region_id = nocreg.id)
AS Wrapped
WHERE Wrapped.medal_name NOT LIKE '%NA%'
GROUP BY Wrapped.medal_name;


-- main subquery version
CREATE TABLE OlympicGold AS 

SELECT DISTINCT Wrapped.region_name AS country,  Wrapped.medal_name AS medal,  COUNT(Wrapped.medal_name) AS medal_count
FROM
(SELECT medal_name, age, full_name, gender, height, weight, noc, region_name, games_year, games_name, season
FROM olympics.medal AS med
JOIN olympics.competitor_event AS compev ON med.id = compev.medal_id
JOIN olympics.games_competitor AS GC ON GC.id = compev.competitor_id
JOIN olympics.person AS pers ON GC.person_id = pers.id
JOIN olympics.person_region AS persreg ON pers.id = persreg.person_id
JOIN olympics.noc_region AS nocreg ON persreg.region_id = nocreg.id
JOIN olympics.games as gam ON GC.games_id = gam.id)
AS Wrapped
WHERE Wrapped.medal_name = 'Gold' AND Wrapped.games_year = 2012
GROUP BY country,  medal
HAVING medal_count > 5
ORDER BY COUNT(Wrapped.region_name) DESC;

SELECT *
FROM OlympicGold;


-- 2012 Olympic Games Gold Medal Count by Country Using CTE
WITH ol AS
	(SELECT medal_name, region_name, games_year, games_name
	FROM olympics.medal AS med
	JOIN olympics.competitor_event AS compev ON med.id = compev.medal_id
	JOIN olympics.games_competitor AS GC ON GC.id = compev.competitor_id
	JOIN olympics.person AS pers ON GC.person_id = pers.id
	JOIN olympics.person_region AS persreg ON pers.id = persreg.person_id
	JOIN olympics.noc_region AS nocreg ON persreg.region_id = nocreg.id
	JOIN olympics.games as gam ON GC.games_id = gam.id)
SELECT DISTINCT
	ol.region_name AS country,
	COUNT(ol.medal_name) AS medal_count,
	ol.medal_name AS medal,
	ol.games_year AS 'year'
FROM ol
WHERE ol.medal_name = 'Gold' AND ol.games_year = 2012
GROUP BY country, medal, 'year'
HAVING medal_count > 0
ORDER BY medal_count DESC;




