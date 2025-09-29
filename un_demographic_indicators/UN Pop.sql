
-- source: https://population.un.org/wpp/downloads?folder=Standard%20Projections&group=Most%20used
-- United Nations, Department of Economic and Social Affairs, Population Division (2024). World Population Prospects 2024, Online Edition. 


SELECT * FROM World_Data.`UN Pop`;

SELECT DISTINCT Type FROM World_Data.`UN Pop`;

-- OG reference CTE
WITH Main AS (
SELECT DISTINCT `Region, subregion, country or area *` `Country, Region`,
`Total Population, as of 1 July (thousands)` `Total Population Thousands`,
`Population Density, as of 1 July (persons per square km)` `Population Density`,
`Population Growth Rate (percentage)` `Population Growth`,
`Mean Age Childbearing (years)`,
`Infant Mortality Rate (infant deaths per 1,000 live births)` `Infant Mortality Rate`,
`Crude Death Rate (deaths per 1,000 population)`,
`Net Migration Rate (per 1,000 population)`
FROM World_Data.`UN Pop`
WHERE Year = "2023" AND (`Total Population, as of 1 July (thousands)` * 1000) > 30000000
)
SELECT `Country, Region`,
ROUND(`Total Population Thousands`,0) `Total Population Thousands`,
ROUND(`Population Density`,2) `Population Den`
FROM Main
ORDER BY `Population Density` DESC
;



-- Ranking Population Density by Country Using CTE & Window Functions
WITH Pop AS (
			SELECT DISTINCT Type,
            `Region, subregion, country or area *` `Country, Region`,
			`Total Population, as of 1 July (thousands)` `TotalPop`,
			`Population Density, as of 1 July (persons per square km)` `PopDens`
			FROM World_Data.`UN Pop`
			WHERE Year = "2023" AND Type = 'Country/Area')
SELECT
	`Country, Region`,
	ROUND(`TotalPop`,2) `Total Population Thousands`,
	RANK() OVER(ORDER BY `TotalPop` DESC) `Population Rank`,
	RANK() OVER(ORDER BY `PopDens` DESC) `Density Rank`,
	ROUND(`PopDens`,2) `Population Density`,
	NTILE(7) OVER(ORDER BY `PopDens` DESC) `Density Group`,
	ROUND((`TotalPop` * `PopDens`) / 100000, 0) `Population Density Score`
FROM Pop
ORDER BY `Population Density` DESC;



/* Avg, Min, & Max Population Growth Rates by Country (1950-2023)
 Ordered by Highest Annual Rates Using CTE & Window Functions */
WITH Pop AS (
			SELECT DISTINCT
			`Region, subregion, country or area *` `Country, Region`,
			Type,
			Year,
			ROUND(`Population Growth Rate (percentage)`,2) `Population Growth`,
			ROUND(`Total Population, as of 1 July (thousands)`,0) `Total Population Thousands`,
			ROUND(`Population Density, as of 1 July (persons per square km)`,2) `Population Density`
FROM World_Data.`UN Pop`)
SELECT DISTINCT
	`Country, Region`,
	Year,
	`Population Growth`,
	ROUND(AVG(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Avg Growth`,
	ROUND(MIN(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Min Growth`,
	ROUND(MAX(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Max Growth`
FROM Pop
WHERE Type = 'Country/Area'
ORDER BY `Population Growth` DESC;



-- Avg, Min, & Max Population Growth by Region (1950-2023) Using CTE & Window Function
WITH Pop AS (
			SELECT DISTINCT
			`Region, subregion, country or area *` `Country, Region`,
			Type,
			Year,
			ROUND(`Population Growth Rate (percentage)`,2) `Population Growth`,
			ROUND(`Total Population, as of 1 July (thousands)`,0) `Total Population Thousands`,
			ROUND(`Population Density, as of 1 July (persons per square km)`,2) `Population Density`
			FROM World_Data.`UN Pop`)
SELECT DISTINCT
	`Country, Region`,
	ROUND(AVG(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Avg Growth`,
	ROUND(MIN(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Min Growth`,
	ROUND(MAX(`Population Growth`) OVER(PARTITION BY `Country, Region`),2) `Max Growth`
FROM Pop
WHERE Type = 'SDG region'
ORDER BY `Max Growth` DESC;

-- Once I created this I realized this could've been achieved by simply using GROUP BY, I also added rankings using ROW_NUMBER for Avg Growth and RANK for Max Growth because it has a tie. Here is that updated version below


-- Avg, Min, & Max Population Growth by Region (1950-2023) Using CTE & GROUP BY
WITH Pop AS (
			SELECT DISTINCT
			`Region, subregion, country or area *` `Country, Region`,
			Type,
			Year,
			ROUND(`Population Growth Rate (percentage)`,2) `Population Growth`,
			ROUND(`Total Population, as of 1 July (thousands)`,0) `Total Population Thousands`,
			ROUND(`Population Density, as of 1 July (persons per square km)`,2) `Population Density`
			FROM World_Data.`UN Pop`)
SELECT DISTINCT
	`Country, Region`,
	ROUND(AVG(`Population Growth`),2) `Avg Growth`,
	ROUND(MIN(`Population Growth`),2) `Min Growth`,
	ROUND(MAX(`Population Growth`),2) `Max Growth`,
    ROW_NUMBER() OVER(PARTITION BY Type ORDER BY ROUND(AVG(`Population Growth`),2) DESC) `Avg Growth Rank`,
	RANK() OVER(PARTITION BY Type ORDER BY ROUND(MAX(`Population Growth`),2) DESC) `Max Growth Rank`
FROM Pop
WHERE Type = 'SDG region'
GROUP BY `Country, Region`, Type
ORDER BY `Max Growth` DESC
;


-- WHERE Type = 'Income Group'
-- WHERE Type = 'SDG region'
-- WHERE Type = 'Region'
-- WHERE Type = 'Subregion'
-- WHERE Type = 'Country/Area'
-- can see direction correlation population growth





-- Countries with Population Growth Rate greater than 2 and Average Childbearing Age less than 30 in 2023
WITH age AS (
			SELECT
				`Region, subregion, country or area *` `Country, Region`,
				Type,
				Year,
				ROUND(`Population Growth Rate (percentage)`,2) `Population Growth`,
				`Mean Age Childbearing (years)` `Mean Age Childbearing`
			FROM World_Data.`UN Pop`)
SELECT `Country, Region`, `Population Growth`, `Mean Age Childbearing`
FROM age
WHERE Year = "2023"
	AND Type = 'Country/Area'
	AND `Mean Age Childbearing` < 30
	AND `Population Growth` > 2
ORDER BY `Mean Age Childbearing` DESC;




