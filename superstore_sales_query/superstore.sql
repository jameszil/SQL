
/* Superstore sample data
https://community.tableau.com/s/question/0D54T00000CWeX8SAL/sample-superstore-sales-excelxls

*/

-- rolling total profit

SELECT * FROM superstore.`Superstore Sample Data`;

RENAME TABLE superstore.`Superstore Sample Data` TO superstore.Sample;

ALTER TABLE superstore.Sample
MODIFY COLUMN `Order Date` DATE;

ALTER TABLE superstore.Sample ADD COLUMN order_date DATE;
UPDATE your_table_name
SET order_date = STR_TO_DATE(`Order Date`, '%m/%d/%y');

SELECT * FROM superstore.Sample;

SELECT COUNT(`Row ID`) FROM superstore.Sample;

DESCRIBE superstore.Sample;


-- CTE setup
WITH rolling AS (SELECT
					`Row Id`,
					`Product ID`,
					`Product Name`,
					Category,
					ROUND(Sales,2) Sales,
					ROUND(Profit,2) Profit,
					ROUND(SUM(Profit) OVER (ORDER BY `Row Id` ASC ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),2) AS `Rolling Sum Profit`,
					ROUND(SUM(Profit) OVER (ORDER BY `Row Id` ASC),2) AS `Running Total`,    
					ROUND(AVG(Profit) OVER (ORDER BY `Row Id` ASC ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),2) AS `Rolling Avg Profit`,
					ROUND(AVG(Profit) OVER (ORDER BY `Row Id` ASC),2) AS `Running Avg`,
					ROUND(FIRST_VALUE(Profit) OVER (PARTITION BY Category ORDER BY `Row Id`),2) `First Profit`,
					ROUND(NTH_VALUE(Profit, 2) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Second Profit`,
					ROUND(LEAD(Profit) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Next Profit`,
					ROUND(LAG(Profit) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Previous Profit`
				FROM superstore.Sample
				ORDER BY `Row Id` ASC)
SELECT *
FROM rolling
;


-- Rolling Calculations and Cumulative Running Total Profit
SELECT
	`Row Id`,
	`Product ID`,
	ROUND(Profit,2) Profit,
	ROUND(SUM(Profit) OVER (ORDER BY `Row Id` ASC ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),2) AS `Rolling Total`,
	ROUND(SUM(Profit) OVER (ORDER BY `Row Id` ASC),2) AS `Running Total`,    
	ROUND(AVG(Profit) OVER (ORDER BY `Row Id` ASC ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),2) AS `Rolling Avg`,
	ROUND(AVG(Profit) OVER (ORDER BY `Row Id` ASC),2) AS `Running Avg`
FROM superstore.Sample
ORDER BY `Row Id` ASC;


-- Trend and Gap Analysis Using...
-- First Value and Nth Value to identify the first and second value in each category
-- Lead and Lag to see values before and after each particular row
SELECT
	`Row Id`,
	`Product ID`,
	Category,
	ROUND(Profit,2) Profit,    
	ROUND(FIRST_VALUE(Profit) OVER (PARTITION BY Category ORDER BY `Row Id`),2) `First Profit`,
	ROUND(NTH_VALUE(Profit, 2) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Second Profit`,
	ROUND(LEAD(Profit) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Next Profit`,
	ROUND(LAG(Profit) OVER (PARTITION BY Category ORDER BY `Row Id` ASC),2) `Previous Profit`
FROM superstore.Sample
ORDER BY `Row Id` ASC;



WITH trend AS
			(SELECT
				`Row Id`,
				`Product ID`,
				`Order Date`,
                Profit,
				STR_TO_DATE(`Order Date`, '%m/%d/%y') AS `Date Ordered`,
				Category
			FROM superstore.Sample)
SELECT
	`Row Id`,
	`Product ID`,
    Category,
    `Date Ordered`,
	ROUND(Profit,2) Profit,    
	ROUND(FIRST_VALUE(Profit) OVER (PARTITION BY Category ORDER BY `Date Ordered` DESC),2) `First Profit`,
	ROUND(NTH_VALUE(Profit, 2) OVER (PARTITION BY Category ORDER BY `Date Ordered` DESC),2) `Second Profit`,
	ROUND(LEAD(Profit) OVER (PARTITION BY Category ORDER BY `Date Ordered` DESC),2) `Next Profit`,
	ROUND(LAG(Profit) OVER (PARTITION BY Category ORDER BY `Date Ordered` DESC),2) `Previous Profit`
FROM trend
ORDER BY `Date Ordered` DESC;





