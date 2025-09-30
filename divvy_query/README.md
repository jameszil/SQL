<h1>Divvy Query</h1>

### Date:
July 2024

### Source:
[Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)

### Background/Context:
Divvy is a bike sharing system in Chicago. The raw data was provided for practice during the Google Data Analytics Certification.

### Objective:
Gain insights on Divvy bike usage in Chicago by identifying the top 10 stations for classic bike users and create custom classification based on bikers by member/nonmember and bike type.

### Main Steps/Highlights:
- Downloaded data, created database and imported csv file to table
- Queries utilizing CASE statement, FORMAT, COUNT, LIMIT, Wild card, Subquery



<h2>Query Output:</h2>

After downloading the data, I created a database and imported the csv file into a new table. From there I was able to create this query that takes a look at the top 10 most common starting stations for classic bikes using a wild card WHERE statement to find only classic bike users, COUNT to count the number of times each station was used, and ORDER BY to see the most common stations first, and lastly LIMIT to find only the top 10 stations.
<br />
<p align="left">
<img src="https://github.com/jameszil/pictures/blob/main/SQL/divvy%20Top%20Starting%20Stations.png?raw=true" height="60%" width="60%" alt="Query Steps"/>
<br />
I created another query utilizing FORMAT(COUNT(*),0) to see easily see the rider count, and a CASE statement wrapped in a subquery to classify riders by names that could be used for marketing purposes moving forward. These classifications could also be used for further analysis to drive decision making. As you see, there is a higher ride count for member than for casual riders. From this we could chose to focus more on driving membership growth by increasing advertising or providing membership discounts or we could possibly lower upfront costs for non members to improve the low ride count for casual riders. The added rider classification also shows that electric bikes have more usage than regular bikes for members and casual riders. This is a proof of concept for creating a new field that groups various categories or criteria together that reveal new insights to help quickly make informed business decisions.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/divvy%20Rider%20Classification%20Case%20Subquery.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<br />
<br />
As there was latitude and longitude fields in this data set, I was also able to connect to the MySQL local server and database I created and map this data within QGIS. I imported the attribute table into QGIS from MySQL server by entering name, host, port, database, and table within QGIS, logging in the host user and password. Once I pulled the desired tables I created a point vector from the coordinates to map the location of each bike rental station in Chicago.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/qgis_mysql%203.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<br />

[See my GIS projects here](https://github.com/jameszil/GIS/tree/main)



