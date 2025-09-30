<h1>Superstore Sales Query</h1>

### Date:
August 2025

### Source:
[Tableau Superstore Sales Data](https://community.tableau.com/s/contentdocument/0694T0000028FZsQAM)

### Background/Context:
This is a version of the classic sample dataset set that is particularly famous in Tableau

### Objective:
I want to practice querying off of sales data to do some more advanced dollar amount calculations

### Main Steps/Highlights:
Window Functions, Rolling Calculations, Cumulative/Running Totals, Trend and Gap Analysis, Text to Date type Conversion


<h2>Query Output:</h2>

####  Rolling Calculations & Cumulative Running Total Profit
First I created a rolling calculation of the company's profit which takes the sum of the previous five rows and the current row using a window function. Next I created another window function that does a running total of profit by each line of Product ID. I also pulled in the average for both of these calculated fields and rounded everything to two decimal places to correctly display dollars and cents in the output table.

<p align="left">
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Superstore%20Rolling%20Calcutions.png?raw=true" height="90%" width="90%" alt="Query Steps"/>
<br />
<br />
From the first few rows it is hard to decipher the difference between these calculated fields, here is a snapshot of the bottom rows of the output to show the functionality of each. The running total adds everything and the running average incrementally changes over time, taking all rows into consideration whereas the rolling total and rolling average fields are only taking the preceding 5 rows and the current row.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Superstore%20Rolling%20Calcutions%20Bottom.png?raw=true" height="70%" width="70%" alt="Query Steps"/>
  
#### Trend and Gap Analysis
Next I experimented with First Value, Nth Value, Lead, and Lag to compare the profits between rows. I partitioned these by Category to see the first and second dollar amounts that came through for that given Category and also the next and previous profit comparing that particular row. This can be very valuable to identify trends in sales data across particular fields.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Superstore%20Trend%20and%20Gap%20Analysis.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<br />
<br />
I recognized that trend analysis would usually consider date fields when comparing rows of data. I was initially having trouble with the date field as it was formatted as text but I was able to add STR_TO_DATE and use the updated the order by. I wrapped it in a CTE to avoid having to repeat this new addition four times in the query.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Superstore%20Trend%20Date.png?raw=true" height="80%" width="80%" alt="Query Steps"/>
<br />
<br />
Now I can easily sort or filter on the date ordered to do a quick comparison of profits among like categories over time. For now, I'm happy with my result.
<br />
<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/Superstore%20Trend%20Date%20Table.png?raw=true" height="80%" width="80%" alt="Query Steps"/>



