<h1>Olympic Query</h1>

### Date:
May 2024

### Source:
[Database Star MySQL Sample Data](https://github.com/bbrumm/databasestar/tree/main/sample_databases/sample_db_olympics/mysql)

### Background/Context:
This data set provides historical Olympic data; however, the data is split up into several tables.

### Objective:
Merge tables and identify which country received the most gold medals in the 2012 Summer Olympics.

### Main Steps/Highlights:
- Created Database and Imported Data Tables
- Joined Tables and Created an Entity Relationship Diagram (ERD)
- Query Including Multiple Joins and Common Table Expression (CTE)



<h2>Query Output:</h2>

<p align="left">
Database and Tables: <br/>
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Olympics%20database.png?raw=true" height="20%" width="20%" alt="Olympic Query Steps"/>
<br />
<br />
Entity Relationship Diagram (ERD):  <br/>
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Olympics%20ERD.png?raw=true" height="60%" width="60%" alt="Olympic Query Steps"/>
<br />
<br />
After joining all the tables, I wrapped it in a subquery and created a CTE so I could reference all the joined tables as "ol" going forward. From there I selected the medal count and filtered for only gold medals in 2012. I selected only unique values to avoid duplicates and sorted by medal count greatest to smallest. This gave me an output for the count of gold medals by country for 2012 Olympic Games.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Olympics%202012%20Gold%20Medal%20Count%20by%20Country.png?raw=true" height="60%" width="60%" alt="Olympic Query Steps"/>
<br />
<br />
From the results we can infer that the United States received the most gold medals, with China coming in second place.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Olympics%20query%20table.png?raw=true" height="40%" width="40%" alt="Olympic Query Steps"/>

