--PROBLEM 01
USE SoftUni
SELECT [FirstName],[LastName] FROM Employees
WHERE [FirstName] LIKE 'Sa%' 

--PROBLEM 02
SELECT [FirstName],[LastName] FROM Employees
WHERE [LastName] LIKE '%ei%'

--PROBLEM 03
SELECT [FirstName] FROM Employees
WHERE [DepartmentID] IN (3,10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005

--PROBLEM 04
SELECT [FirstName], [LastName] FROM Employees
WHERE [JobTitle] NOT LIKE '%engineer%'

--PROBLEM 05
SELECT [Name] FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name] ASC

--PROBLEM 06
SELECT [TownID],[Name] FROM Towns
WHERE [Name] LIKE 'M%' 
OR [Name] LIKE 'K%'
OR [Name] LIKE 'B%'
OR [Name] LIKE 'E%'
ORDER BY [Name] ASC

--PROBLEM 07
SELECT [TownID],[Name] FROM Towns
WHERE [Name] NOT LIKE 'R%' 
AND [Name] NOT LIKE 'B%'
AND [Name] NOT LIKE 'D%'
ORDER BY [Name] ASC

--PROBLEM 08
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT [FirstName] ,[LastName] FROM Employees
WHERE YEAR(HireDate) > 2000

--PROBLEM 09
SELECT [FirstName], [LastName] FROM Employees
WHERE LEN([LastName]) = 5 

--PROBLEM 10
SELECT [EmployeeID] ,[FirstName] ,[LastName] ,[Salary] 
,DENSE_RANK() OVER(PARTITION BY [SALARY] ORDER BY [EmployeeID]) AS [Rank]
FROM Employees
WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC

--PROBLEM 11
SELECT *
FROM (SELECT [EmployeeID] ,[FirstName] ,[LastName] ,[Salary] 
,DENSE_RANK() OVER(PARTITION BY [SALARY] ORDER BY [EmployeeID]) AS [Rank]
FROM Employees) AS Rank_Employees_by_Salary
WHERE [Salary] BETWEEN 10000 AND 50000 AND [Rank] = 2
ORDER BY [Salary] DESC

--
USE Geography
--

--PROBLEM 12
SELECT [CountryName] AS [Country Name] , IsoCode AS [ISO Code] 
FROM [Countries]
WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [ISO Code]

--PROBLEM 13
SELECT [PeakName] , [RiverName] , CONCAT(LOWER(LEFT(PeakName,LEN(PeakName)-1)),LOWER(RiverName)) AS [Mix]
FROM Peaks AS [p] INNER JOIN Rivers AS [r] ON RIGHT(p.PeakName,1) = LEFT(r.RiverName,1)
ORDER BY [Mix]

--
USE Diablo
--

--PROBLEM 14
SELECT TOP(50) [Name], FORMAT([Start],'yyyy-MM-dd') AS [Start]
FROM [Games]
WHERE YEAR([Start]) IN (2011,2012)
ORDER BY [Start] , [Name]

--PROBLEM 15
SELECT [Username],SUBSTRING([Email],CHARINDEX('@',[Email]) +1,LEN([Email]) - CHARINDEX('@',[Email])+1) AS [Email Provider] 
FROM Users
ORDER BY [Email Provider], [Username]

--PROBLEM 16
SELECT [Username] , [IpAddress] AS [IP Address]
FROM Users
WHERE [IpAddress] LIKE '___.1%.%.___'
ORDER BY [Username]

--PROBLEM 17
SELECT
[Name],
CASE
    WHEN DATEPART(HOUR,[Start]) >= 0 AND DATEPART(HOUR,[Start]) <12 THEN 'Morning'
    WHEN DATEPART(HOUR,[Start]) >= 12 AND DATEPART(HOUR,[Start]) < 18 THEN 'Afternoon'
	WHEN DATEPART(HOUR,[Start]) >= 18 AND DATEPART(HOUR,[Start]) < 24 THEN 'Evening'
END AS [Part of the Day],
CASE
    WHEN [Duration] <= 3 THEN 'Extra Short'
    WHEN [Duration] > 3 AND [Duration] <= 6 THEN 'Short'
	WHEN [Duration] > 6  THEN 'Long'
	ELSE 'Extra Long'
END AS [Duration]
FROM [Games]
ORDER BY [Name], [Duration], [Part of the Day]

--
USE Orders
--

--PROBLEM 18
SELECT [ProductName], 
[OrderDate],
DATEADD(DAY ,3 ,[OrderDate]) AS [Pay Due],
DATEADD(MONTH ,1 ,[OrderDate]) AS [Deliver Due] 
FROM Orders 
