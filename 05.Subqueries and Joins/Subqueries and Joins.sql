--PROBLEM 01
SELECT TOP 5
e.[EmployeeID],
e.[JobTitle],
a.[AddressID],
a.[AddressText]
FROM 
[Employees] AS e JOIN [Addresses] AS a ON a.AddressID = e.AddressID
ORDER BY a.AddressID

--PROBLEM 02
SELECT TOP 50
e.[FirstName],
e.[LastName],
t.[Name] AS Town,
a.[AddressText]
FROM 
[Employees] AS e 
JOIN [Addresses] AS a ON a.AddressID = e.AddressID
JOIN [Towns] AS t ON a.TownID = t.TownID
ORDER BY e.[FirstName], e.[LastName]

--PROBLEM 03
SELECT 
e.[EmployeeID],
e.[FirstName],
e.[LastName],
d.[Name] AS [DeparmentName]
FROM
[Employees] AS e
JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
WHERE d.[Name] = 'Sales'
ORDER BY EmployeeID

--PROBLEM 04
SELECT TOP 5
e.[EmployeeID],
e.[FirstName],
e.[Salary],
d.[Name] AS [DeparmentName]
FROM
[Employees] AS e
JOIN [Departments] AS d ON e.DepartmentID = d.[DepartmentID]
WHERE [Salary] > 15000
ORDER BY e.[DepartmentID]

--PROBLEM 05
SELECT TOP 3
e.[EmployeeID],
e.[FirstName]
FROM
[Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep ON ep.EmployeeID = e.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.[EmployeeID]

--PROBLEM 06
SELECT
e.[FirstName],
e.[LastName],
e.[HireDate],
d.[Name] AS [DeptName]
FROM
[Employees] AS e 
JOIN [Departments] AS d ON e.DepartmentID = d.DepartmentID
WHERE e.[HireDate] > '1-1-1999' AND d.[Name] IN ('Finance', 'Sales')
ORDER BY e.[HireDate]

--PROBLEM 07
SELECT TOP 5
e.[EmployeeID],
e.[FirstName],
p.[Name] AS [ProjectName]
FROM
[Employees] AS e 
JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE p.[StartDate] > '8-13-2002' AND p.[EndDate] IS NULL
ORDER BY e.[EmployeeID]

--PROBLEM 08
SELECT
e.[EmployeeID],
e.[FirstName],
CASE
    WHEN YEAR(p.[StartDate]) >= 2005 THEN NULL
    ELSE p.[Name]
END AS [ProjectName]
FROM
[Employees] AS e 
JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE e.[EmployeeID] = 24

--PROBLEM 09
SELECT
e.[EmployeeID],
e.[FirstName],
e2.[EmployeeID],
e2.[FirstName]
FROM
[Employees] AS e 
JOIN [Departments] AS d ON d.[DepartmentID] = e.[DepartmentID]
JOIN [Employees] AS e2 ON e.[ManagerID] = e2.[EmployeeID]
WHERE e2.EmployeeID IN (3,7)
ORDER BY e.EmployeeID

--PROBLEM 10
SELECT TOP 50
e.[EmployeeID],
CONCAT(e.FirstName,' ',e.LastName) AS [EmployeeName],
CONCAT(e2.FirstName,' ',e2.LastName),
d.[Name] AS [DeparmentName]
FROM
[Employees] AS e 
JOIN [Departments] AS d ON d.[DepartmentID] = e.[DepartmentID]
JOIN [Employees] AS e2 ON e.[ManagerID] = e2.[EmployeeID]

--PROBLEM 11
SELECT
MIN(avg) AS [MinAverageSalary]
FROM(
SELECT
AVG([Salary]) AS avg
FROM
[Employees]
GROUP BY [DepartmentID]) AS AverageSalary

--PROBLEM 12
SELECT
mc.[CountryCode],
m.[MountainRange],
p.[PeakName],
p.[Elevation]
FROM
[Peaks] AS p 
JOIN [Mountains] AS m ON p.MountainId = m.Id
JOIN [MountainsCountries] AS mc ON m.Id = mc.MountainId
WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--PROBLEM 13
SELECT
[CountryCode],
COUNT([CountryCode]) AS [MountainRanges]
FROM
[MountainsCountries]
WHERE [CountryCode] IN ('BG','RU','US')
GROUP BY [CountryCode]

--PROBLEM 14
SELECT TOP 5
c.[CountryName],
r.[RiverName]
FROM
[CountriesRivers] AS cr
RIGHT JOIN [Rivers] AS r ON r.Id = cr.RiverId
RIGHT JOIN [Countries] AS c ON c.CountryCode = cr.CountryCode
WHERE [ContinentCode] = 'AF'
ORDER BY c.[CountryName]

--PROBLEM 15
SELECT [CC] FROM(
SELECT 
([CountryCode]) AS CC
FROM
[Countries] AS co
GROUP BY [ContinentCode]) AS cc

--PROBLEM 16
SELECT c.[ContinentCode], c.[CurrencyCode], count(*)
FROM [Countries] as c
GROUP BY c.[ContinentCode], c.[CurrencyCode]
HAVING count(*) > 1
AND count(*) = (SELECT top 1 count(*)
FROM [Countries] as csq
WHERE csq.[ContinentCode] = c.[ContinentCode]
GROUP BY csq.[ContinentCode], csq.[CurrencyCode]
ORDER BY count(*) DESC)
ORDER BY c.[ContinentCode]