<h1>Gapminder Query</h1>

### Date:
June 2025

### Source:
[FREE DATA FROM WORLD BANK VIA GAPMINDER.ORG, CC-BY LICENSE](https://www.gapminder.org/data/)

[Gapminder Mean Income - Dataset](http://gapm.io/dmincpcap_cppp)

### Background/Context:
This data was provided by Gapminder and comes from the World Bank

### Objective:
Gain insights on the change in daily income and life expectancy over the past few decades

### Main Steps/Highlights:
Troubleshooting errors, hanging data types, altering tables, join with USING, custom fields, join multiple CTEs



<h2>Query Output:</h2>

#### Data Preparation

As we all know, datasets don't always come wrapped in a bow. Sometimes data manipulation and cleaning are necessary. In this example, the sample data provided had hidden characters that were causing the query to not recognize the 'country' field. I had to alter the tables to remove the hidden characters from the 'country' field and ensure the data type was converted to text using VARCHAR. 
<br />
<p align="left">
<img src="https://github.com/jameszil/pictures/blob/main/SQL/gapminder%20change%20data%20type.png?raw=true" height="60%" width="60%" alt="Query Steps"/>
<br />
<br />
Next, I made a query showing the change in daily income over a 20 year period by country.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/gapminder%20daily%20income%20change.png?raw=true" height="60%" width="60%" alt="Query Steps"/>
<br />
<br />
We can see that Guyana has by far had the greastest increase in daily income by percentage of earnings over the last 20 years. Vietnam, Romania, Bulgaria, China, and Lithuania all had rapid growth above 200% as well.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/gapminder%20Daily%20Income%20CTE.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<img src="https://github.com/jameszil/pictures/blob/main/SQL/gapminder%20Daily%20income%20table.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<br />
<br />
Then I was able to create a similar query to show the change of life expectancy over a 20 year period for each country. After that, I created two subqueries and wrapped these in Common Table Expressions (CTEs). I was able to join the CTEs into a single query to get both outputs to populate in a succinct table. The CTEs help organize both the query and the result grid for readability. The user can filter on LifeExpPctChange or simply change the ORDER BY statement to quickly see the countries with the biggest change in life expectancy.


