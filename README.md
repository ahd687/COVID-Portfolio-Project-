# Covid 19 Data Exploration with SQL

## Project Overview
An exploratory data analysis project on Covid19 cases, deaths, and vaccinations from, Jan 02, 2020 to  Dec 28, 2022. 

 ```SQL
---- The Date that we got ours Data 

SELECT CAST(MAX(date) AS DATE) AS  [Date that we got our Date From  https://ourworldindata.org/]
FROM [dbo].[CovidDeaths]
```

This project is based on MS SQL Server

### Skills used:
* Joins 
* CTE's
* Temp Tables
* Windows Functions
* Aggregate Functions
* Creating Views
* Converting Data Types

## Code and Resources Used
*  Alex The Analyst Youtube Chanel https://www.youtube.com/watch?v=qfyynHBFOsM&list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f&index=2 
* Data Source: ourworldindata.org Links https://ourworldindata.org/covid-deaths
* Rows: 246017 Columns: 21 (We have been taken into consideration the null values  during the analysis )
