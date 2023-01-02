

-----              Covid 19 Data DATA EXPLORATION with SQL

---- Skills used: Converting Data Types, Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, 
--                  Creating Views


---- The Date that we got ours Data 

SELECT CAST(MAX(date) AS DATE) AS  [Date that we got our Date From  https://ourworldindata.org/]
FROM [dbo].[CovidDeaths]

---- Inspection ours Tables
SELECT * 
FROM [dbo].[CovidDeaths]
ORDER BY 3,4

SELECT * 
FROM [dbo].[CovidVaccinations]
ORDER BY 3,4

-----  Selecting the columns that we are going to use in our analyse

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeaths]
ORDER BY 1,2


-----   Percentage of Tatal Deaths on Tatal Cases

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [dbo].[CovidDeaths]
ORDER BY 1,2

----   The top 10 values of  DeathPercentage in the USA 
SELECT TOP (10) date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
fROM [dbo].[CovidDeaths]
WHERE location LIKE ('%States%')
ORDER BY DeathPercentage DESC
 
 -----   Percentage of Tatal Cases in Population
         --  Percentage of population got covid (in USA)

SELECT location, date, population, total_cases, (total_cases/population)*100 AS CasePercentage
FROM [dbo].[CovidDeaths]
WHERE location LIKE ('%States%')
ORDER BY 1,2

-----   Countries with highest Infection Rate Compared to Population

SELECT location, population, 
        MAX(CAST(total_cases AS int)) AS HighestInfectionCount,
		MAX((cast(total_cases AS int))/population )*100 AS PercentagePopuationInfected
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL 
GROUP BY location, population
ORDER BY 3 DESC


-----   Continents (Regions) Infection Rate  Compared to Population 

SELECT continent, 
        MAX(CAST(total_cases AS int)) AS HighestInfectionCount, ---
		MAX((CAST(total_cases AS int)/population))*100 AS PercentagePopuationInfected
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 3 DESC

----    Countries with highest Deaths number  Per Population

SELECT location, MAX(CAST(total_deaths AS int)) AS ToatalDeathCount
FROM [dbo].[CovidDeaths]
WHERE continent IS  NULL
--WHERE location = 'United States'
GROUP BY location
ORDER BY ToatalDeathCount DESC

-----    Continents with highest Deaths number  Per Populati

SELECT continent, MAX(CAST(total_deaths AS int)) AS ToatalDeathCount
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY ToatalDeathCount DESC




 -----   Percentage of Total Deaths per Total Cases
         --  

SELECT  date, SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS int)) AS TotalDeaths, 
               SUM(CAST(new_deaths AS int))/  SUM(new_cases)*100 AS DeathPercentage
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
--WHERE location LIKE ('%States%')
GROUP BY date
ORDER BY 4 DESC


 -----   Worldwide  of Tatal_Cases and Total_Deaths  and the percentage of Total_Deaths per Tatal_cases
         --  

SELECT   Max(CAST(date AS DATE)) ReportedDate, SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS int)) AS TotalDeaths, 
         SUM(CAST(new_deaths AS int))/  SUM(new_cases)*100 AS DeathPercentage
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL


----     Looking at Total Population vs Vaccinations
WITH PopvsVac (Continent , Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT D.continent , D.location, D.date, D.population, V.new_vaccinations
, SUM(CAST(V.new_vaccinations AS bigint)) OVER (PARTITION BY D.location ORDER BY D.location, 
  D.date) AS RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] D
JOIN [dbo].[CovidVaccinations]	V   
     ON D.location =V.location 
	 AND D.date =V.date
WHERE D.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac



----- Create a TEMP table ----------------------------

DROP TABLE IF EXISTS #PercentagePopulationVaccinated

CREATE TABLE #PercentagePopulationVaccinated
(
 continent NVARCHAR(250), 
 location NVARCHAR(250), 
 date DATETIME, 
 population NUMERIC,
 new_vaccinations NUMERIC,
 RollingPeopleVaccinated NUMERIC
)

INSERT INTO #PercentagePopulationVaccinated
SELECT D.continent , D.location, D.date, D.population, V.new_vaccinations
, SUM(CAST(V.new_vaccinations AS bigint)) OVER (PARTITION BY D.location ORDER BY D.location, 
  D.date) AS RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] D
JOIN [dbo].[CovidVaccinations]	V   
     ON D.location =V.location 
	 AND D.date =V.date
WHERE D.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentageVaccinated
FROM #PercentagePopulationVaccinated


---- Creating View to store date
DROP VIEW IF EXISTS  PercentPopulationVaccinated
CREATE VIEW  PercentPopulationVaccinated AS
SELECT D.continent , D.location, D.date, D.population, V.new_vaccinations
, SUM(CAST(V.new_vaccinations AS bigint)) OVER (PARTITION BY D.location ORDER BY D.location, 
  D.date) AS RollingPeopleVaccinated
FROM [dbo].[CovidDeaths] D
JOIN [dbo].[CovidVaccinations]	V   
     ON D.location =V.location 
	 AND D.date =V.date
WHERE D.continent IS NOT NULL
--ORDER BY 2,3

----- Total cases per Year

SELECT YEAR(date) AS Year, SUM(new_cases) AS [Total Caeses]
FROM [dbo].[CovidDeaths]
GROUP BY YEAR(date)
ORDER BY 1



 ----Count of  Fist Shot and Fully vaccinated by Country

SELECT  continent, MAX(CAST(people_vaccinated AS bigint)) [First Shot], 
                   MAX(CAST (people_fully_vaccinated AS bigint)) AS [Fully Vaccinated]
FROM [dbo].[CovidVaccinations]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 1


----Count of  Fist Shot and Fully vaccinated by Year

SELECT  YEAR(date) AS Year, MAX(CAST(people_vaccinated AS bigint)) [First Shot], 
                   MAX(CAST (people_fully_vaccinated AS bigint)) AS [Fully Vaccinated]
FROM [dbo].[CovidVaccinations]
WHERE continent IS NOT NULL
GROUP BY YEAR(date)
ORDER BY 1