
-- source: https://divvy-tripdata.s3.amazonaws.com/index.html
-- From Google Data Analytics Certificate

-- Sample
SELECT *
FROM divvy.divvysimple
LIMIT 10;

-- Month Sort
SELECT rideable_type, started_date, start_station_name
FROM divvy.divvysimple
ORDER BY started_date ASC;

-- Count of Rides by Bike Type
SELECT DISTINCT rideable_type, COUNT(rideable_type)
FROM divvy.divvysimple AS d
GROUP BY rideable_type;

-- Count of Rides by Member Type
SELECT DISTINCT member_casual, COUNT(member_casual)
FROM divvy.divvysimple AS d
GROUP BY member_casual;

-- Top 10 Starting Stations for Classic Bikes
SELECT start_station_name, COUNT(start_station_name) start_station_count
FROM divvy.divvysimple
WHERE rideable_type LIKE '%classic%'
GROUP BY start_station_name
ORDER BY start_station_count DESC
LIMIT 10;

-- Top 10 Ending Stations
SELECT end_station_name, end_lat, end_lng, COUNT(end_station_name)
FROM divvy.divvysimple
WHERE rideable_type LIKE '%classic%'
GROUP BY rideable_type, end_station_name, end_lat, end_lng, member_casual
ORDER BY COUNT(end_station_name) DESC
LIMIT 10;

-- Case Query
SELECT rideable_type, member_casual,
	CASE
	WHEN member_casual = "casual" AND rideable_type = "classic_bike" THEN "Vintage Voyager"
    WHEN member_casual = "member" AND rideable_type = "classic_bike" THEN "Eco Explorer"
    WHEN member_casual = "casual" AND rideable_type = "electric_bike" THEN "Classic Connoisseur"
    WHEN member_casual = "member" AND rideable_type = "electric_bike" THEN "Electric Elite"
	ELSE "Unknown"
	END AS rider_classification,
	FORMAT(COUNT(CASE
	WHEN member_casual = "casual" AND rideable_type = "classic_bike" THEN "Vintage Voyager"
    WHEN member_casual = "member" AND rideable_type = "classic_bike" THEN "Eco Explorer"
    WHEN member_casual = "casual" AND rideable_type = "electric_bike" THEN "Classic Connoisseur"
    WHEN member_casual = "member" AND rideable_type = "electric_bike" THEN "Electric Elite"
	ELSE "Unknown"
	END), 0) AS rider_count
FROM divvy.divvysimple
GROUP BY
	rideable_type, member_casual, rider_classification;


-- Count of Riders by Classification Based on Member Type and Ride Type Using Case Statement Subquery
SELECT rideable_type, member_casual, rider_classification, FORMAT(COUNT(*),0) AS rider_count
FROM
	(SELECT rideable_type, member_casual,
		CASE
		WHEN member_casual = "casual" AND rideable_type = "classic_bike" THEN "Vintage Voyager"
		WHEN member_casual = "member" AND rideable_type = "classic_bike" THEN "Eco Explorer"
		WHEN member_casual = "casual" AND rideable_type = "electric_bike" THEN "Classic Connoisseur"
		WHEN member_casual = "member" AND rideable_type = "electric_bike" THEN "Electric Elite"
		ELSE "Unknown"
		END AS rider_classification
	FROM divvy.divvysimple) AS rider_group
GROUP BY rideable_type, member_casual, rider_classification;





-- JOIN
SELECT *
FROM  divvy.divvysimple d
JOIN divvy.divvybased b
ON d.member_casual = b.member_id;

/* CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
); */

-- add column
ALTER TABLE divvy.divvybased
ADD COLUMN key_id VARCHAR(255) AFTER member_id;

-- create primary key
ALTER TABLE Persons
ADD PRIMARY KEY (ID);

ALTER TABLE divvy.divvybased
ADD CONSTRAINT
PRIMARY KEY (key_id);

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
); 

