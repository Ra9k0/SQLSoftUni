--PROBLEM 01
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS SELECT [FirstName], [LastName] 
FROM [Employees]
WHERE [Salary] > 35000

GO

--PROBLEM 02
CREATE PROC usp_GetEmployeesSalaryAboveNumber @Num DECIMAL(18,4)
AS
SELECT [FirstName], [LastName] 
FROM [Employees]
WHERE [Salary] >= @Num

GO

--PROBLEM 03
CREATE PROC usp_GetTownsStartingWith @Letter VARCHAR(30)
AS
SELECT [Name]
FROM [Towns]
WHERE [Name] LIKE @Letter + '%'

GO

--PROBLEM 04
CREATE PROC usp_GetEmployeesFromTown @TownName VARCHAR(50)
AS
SELECT [FirstName], [LastName] 
FROM [Employees] AS e
JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
JOIN [Towns] AS t ON a.[TownID] = t.TownID
WHERE t.[Name] = @TownName

GO

--PROBLEM 05
CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18,4))

RETURNS VARCHAR(7)

BEGIN

DECLARE @type VARCHAR(7)

IF @salary < 30000
SET @type = 'Low'

ELSE IF @salary > 50000
SET @type = 'High'

ELSE
SET @type = 'Average'

RETURN @type

END;

GO

--PROBLEM 06
CREATE PROC usp_EmployeesBySalaryLevel @level VARCHAR(7)
AS
SELECT [FirstName], [LastName]
FROM [Employees]
WHERE dbo.ufn_GetSalaryLevel([Salary]) = @level

GO

--PROBLEM 07
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))

RETURNS BIT

BEGIN

DECLARE @Index INT = 1

WHILE @Index <= LEN(@word)
BEGIN

DECLARE @CurrChar CHAR = SUBSTRING(@word, @Index, 1)

IF @setOfLetters NOT LIKE '%'+@CurrChar+'%'
BEGIN
RETURN 0
END

SET @Index = @Index + 1
END

RETURN 1

END

GO

--PROBLEM 08
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment
    @departmentId INT
AS
BEGIN
    DECLARE @delEmployees TABLE(Id INT);
    INSERT INTO @delEmployees
    SELECT EmployeeID
    FROM Employees
    WHERE DepartmentID = @departmentId;

    DELETE FROM EmployeesProjects 
    WHERE EmployeeID IN (SELECT * FROM @delEmployees);

    UPDATE Employees
    SET ManagerID = NULL
    WHERE ManagerID IN (SELECT * FROM @delEmployees);

    ALTER TABLE Departments ALTER COLUMN ManagerID INT NULL;
    UPDATE Departments
    SET ManagerID = NULL
    WHERE ManagerID IN (SELECT * FROM @delEmployees);

    DELETE FROM Employees
    WHERE EmployeeID IN (SELECT * FROM @delEmployees);

    DELETE FROM Departments 
    WHERE DepartmentID = @departmentId;

    SELECT COUNT(*)
    FROM Employees
    WHERE DepartmentID = @departmentId;
END

GO

--PROBLEM 09
CREATE PROC usp_GetHoldersFullName
AS
SELECT CONCAT([FirstName], + ' ' + [LastName]) AS [Full Name]
FROM
[AccountHolders]

GO

--PROBLEM 10
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@number INT)
AS
BEGIN
SELECT [FirstName], [LastName]
FROM(
SELECT [FirstName], [LastName], [AccountHolderId]
FROM [AccountHolders] AS ah
JOIN [Accounts] AS a ON ah.Id = a.AccountHolderId
GROUP BY [FirstName], [LastName], [AccountHolderId]) AS ahh
JOIN [Accounts] AS aa ON ahh.AccountHolderId = aa.AccountHolderId
GROUP BY [FirstName], [LastName]
HAVING SUM(Balance) > @number
ORDER BY [FirstName], [LastName]
END