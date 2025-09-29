
-- source:
-- https://www.gapminder.org/data/
-- http://gapm.io/dmincpcap_cppp
-- FREE DATA FROM WORLD BANK VIA GAPMINDER.ORG, CC-BY LICENSE

-- Gini Inequality, 2024 by Country
SELECT g.country, g.`2024` AS gini, l.`2024` AS lex, c.`2024` AS cppp
FROM gapminder.gini g
JOIN gapminder.lex l
USING (country)
JOIN gapminder.mincpcap_cppp c
USING (country)
WHERE g.`2024` < '2024'
ORDER BY gini DESC;

-- Life expectancy at birth, 2024 by Country
SELECT g.country, g.`2024` AS gini, l.`2024` AS lex, c.`2024` AS cppp
FROM gapminder.gini g
JOIN gapminder.lex l
USING (country)
JOIN gapminder.mincpcap_cppp c
USING (country)
WHERE l.`2024` < '2024'
ORDER BY lex DESC;

-- Daily Income, 2024 by Country
SELECT g.country, g.`2024` AS gini, l.`2024` AS lex, c.`2024` AS cppp
FROM gapminder.gini g
JOIN gapminder.lex l
USING (country)
JOIN gapminder.mincpcap_cppp c
USING (country)
WHERE c.`2024` < '2024'
ORDER BY cppp DESC;


-- Daily Income 20 Year Change by Country (2005-2025)
SELECT
	g.country AS Country,
	FORMAT(c.`2024`,0) AS DailyIncome,
	ROUND((((c.`2025` - c.`2005`) / c.`2005`)*100),0) AS IncomePctChange
FROM gapminder.gini g
	JOIN gapminder.lex l
	USING (country)
	JOIN gapminder.mincpcap_cppp c
	USING (country)
WHERE c.`2024` < '2024'
ORDER BY IncomePctChange DESC;





-- Life Expectancy 20 Year Change by Country (2005-2025)
SELECT
	l.country AS Country,
	FORMAT(l.`2024`,0) AS LifeExpectancy,
	ROUND((((l.`2025` - l.`2005`) / l.`2005`)*100),0) AS LifeExpPctChange
FROM gapminder.gini g
	JOIN gapminder.lex l
	USING (country)
	JOIN gapminder.mincpcap_cppp c
	USING (country)
WHERE l.`2024` < '2024'
ORDER BY LifeExpPctChange DESC;



-- Daily Income and Life Expectancy 20 Year Change by Country (2005-2025) Using Combined CTE
WITH di  AS (
			SELECT
				g.country AS Country,
				FORMAT(c.`2024`,0) AS DailyIncome,
				ROUND((((c.`2025` - c.`2005`) / c.`2005`)*100),0) AS IncomePctChange
			FROM gapminder.gini g
				JOIN gapminder.lex l USING (country)
				JOIN gapminder.mincpcap_cppp c USING (country)
			WHERE c.`2024` < '2024'),
	li AS (
			SELECT
				l.country AS Country,
				FORMAT(l.`2024`,0) AS LifeExpectancy,
				ROUND((((l.`2025` - l.`2005`) / l.`2005`)*100),0) AS LifeExpPctChange
			FROM gapminder.gini g
				JOIN gapminder.lex l USING (country)
				JOIN gapminder.mincpcap_cppp c USING (country)
			WHERE l.`2024` < '2024')
SELECT *
FROM di JOIN li ON di.Country = li.Country
ORDER BY IncomePctChange DESC;





-- troubleshoot data type
SELECT *
FROM gapminder.mincpcap_cppp;

DELETE FROM gapminder.gini g WHERE country = 'country)';

DESCRIBE gapminder.gini;
DESCRIBE gapminder.lex;
DESCRIBE gapminder.mincpcap_cppp;

ALTER TABLE gapminder.gini CHANGE `﻿ï»¿country` `country` VARCHAR(255);
ALTER TABLE gapminder.lex CHANGE `ï»¿country` `country` VARCHAR(255);
ALTER TABLE gapminder.mincpcap_cppp CHANGE `ï»¿country` `country` VARCHAR(255);

ALTER TABLE gapminder.gini CHANGE `﻿country` `country` VARCHAR(255);
ALTER TABLE gapminder.lex CHANGE `﻿country` `country` VARCHAR(255);
ALTER TABLE gapminder.mincpcap_cppp CHANGE `﻿country` `country` VARCHAR(255);
