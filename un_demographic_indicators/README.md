<h1>UN Demographic Indicators Query</h1>

### Date:
July 2025

### Source:
[United Nations, Department of Economic and Social Affairs, Population Division (2024). World Population Prospects 2024, Online Edition](https://population.un.org/wpp/downloads?folder=Standard%20Projections&group=Most%20used)

### Background/Context:
I pulled data coming from United Nations, Department of Economic and Social Affairs, this provided a number of Demographic Indicators to query off of

### Objective:
Create a rank of population density by country. Come up with minimum, average, and maximum rate of population growth by year, country, and region.

### Main Steps/Highlights:
Multiple CTEs, Window Functions, Ranking, Partitioning, experiment with getting the same output in multiple ways, replicating Window Function output using Group By



<h2>Query Output:</h2>

Once I downloaded and cleaned the data, I imported the csv file into a new SQL table. Then I wrote a query that Ranks countries by population and population density. I also created a density group field which puts country into 7 different categories based on their respective population densities. Lastly, I created a population density index that takes the total population into consideration meaning countries with high populations will be weighted higher on the score than countries with low populations. This helps highlight countries like India and Bangladesh that are high on both population and density ranks instead of showing countries with limited population sizes as small islands often show up higher on the density rank. I achieved this by creating a CTE and utilizing various window functions
<br />

#### Population Density

<p align="left">
<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Density.png?raw=true" height="70%" width="70%" alt="Query Steps"/>
<br />
<br />
Here I created the minimum, average, and maximum rate of population growth by year for each country. This filter by default highlights the top years for population growth. As we can see Qatar had two years of back to back rapid growth in 2006 and 2007. In 1964, Hong Kong and Macao had the fastest population growth of any country ever recorded in modern history. Although these special administrative regions of China saw tremendous growth, it seems that Kuwait, Qatar, and United Arab Emirates have seen steady growth year by year as each of these countries have an average growth of 6 and above, whereas Hong Kong and Macao both have a growth rate of 3, about half that of the countries mentioned in the Arabian Peninsula. Just from the short preview of this query we are able to extract many insights about countries and regions growth trends throughout several decades.

#### Population Growth Rate by Country

<br />
<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Growth%20Rate.png?raw=true" height="70%" width="70%" alt="Query Steps"/>
<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Growth%20Rate%20Table.png?raw=true" height="70%" width="70%" alt="Query Steps"/>

Then I pulled just the UN Sustainable Development Goals regions regardless of year and found the highest growth rate and the average growth rate for each region. We can see that Sub-Saharan Africa has the highest average and max population growth rate while Europe and Northern America has the lowest.

This output could be used to compare with other studies such as the demographic transition which states that more developed nations tend to have slower birth rates and population growth rates. Of course is not always the case, but there is a general correlation between indexes that track human development and population growth rates. From a quick glance of this simple table output we can see the top and bottom regions affirm this while the other regions in between may be slightly more complex. In recent years there has been a shift to not group countries in the traditional geographic regions that we have used for decades as the diaspora of countries with high and low population growth rates among other valuable metrics varies greatly within each region. When looking at region based outputs we should understand there is always more to discover than what we can see on a rolled up snapshot, but they this view still provides a valuable quick look at the data without having to dig too deep. Many stakeholders prefer high level outputs like this one.
<br />
#### Population Growth Rate by Region
<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Growth%20by%20Region.png?raw=true" height="70%" width="70%" alt="Query Steps"/>

Once I created this, I realized this could've been achieved by simply using GROUP BY, I also added rankings using ROW_NUMBER for Avg Growth and RANK for Max Growth because it has a tie. Here is that updated version below

<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Growth%20by%20Region%20GROUP%20BY.png?raw=true" height="70%" width="70%" alt="Query Steps"/>
<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Population%20Growth%20by%20Region%20GROUP%20BY%20Table.png?raw=true" height="70%" width="70%" alt="Query Steps"/>

For my last query using this dataset, I wanted to come up with a list of countries that met a very specific criteria. I wanted to see countries with a high population growth rate and relatively low average childbearing age. 41 countries had a population growth rate greater than 2 and an average childbearing age less than 30. This query was less about drawing a conclusion and more about exploring different filtering possibilities within the same data to get a different output of countries for population growth, a metric we'd previously looked at.

<img src="https://github.com/jameszil/pictures/blob/main/SQL/UN%20Pop%20Growth%20and%20Childbearing%20Age.png?raw=true" height="70%" width="70%" alt="Query Steps"/>

