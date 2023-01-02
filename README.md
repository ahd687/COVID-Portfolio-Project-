# Covid 19 Data Exploration with SQL

## Project Overview
An exploratory data analysis project on Covid19 cases, deaths, and vaccinations from, Jan 02, 2020 to  Dec 28, 2022. 

 ```SQL
---- The Date that we got ours Data 

SELECT CAST(MAX(date) AS DATE) AS  [Date that we got our Date From  https://ourworldindata.org/]
FROM [dbo].[CovidDeaths]
```
![alt text](https://github.com/ahd687/COVID-Portfolio-Project-/blob/main/Datadate.png)

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


## Importing Data Into SQL Server
We imported data from SQL Server Import and Export Data (64 bit) wizard, is launched from the Start Menu.

## SQL Data Exploration
*  Percentage of Tatal Deaths on Tatal Cases
*  Percentage of Tatal Cases vs Population
*  Countries with highest Infection Rate Compared to Population
*  Continents (Regions) Infection Rate  Compared to Population 
*  Countries with highest Deaths number  Per Population
*  Continents with highest Deaths number  Per Population
*  Percentage of Total Deaths per Total Cases
*  Person Vaccinatinated VS  Population
*  Total cases per Year
