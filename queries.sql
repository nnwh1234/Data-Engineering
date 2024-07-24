-- Q1. Create a query to list the number of fresh models and finetuned model among all models in the repository.
SELECT	
	COUNT(ISNULL(ParentModelID, 0)) - COUNT(ParentModelID) AS 'FreshModel', 
	COUNT(ParentModelID) AS 'FinetunedModel'
FROM Models;

/* Q2. Create a subquery to list the number of models of each type without being 
assigned to any order ever. Order the results by model type in alphabetical order
and include the average and maximum testing accuracy (rounded to 1 decimal
place in %) of each model type. Only list model types that have at least 1 model
unassigned to any order. */

-- Reference for FORMAT: https://www.w3schools.com/sql/func_sqlserver_format.asp

SELECT 
	ModelTypeName AS ModelType,
	COUNT(ModelTypeName) AS NumberUnassigned,
	CAST(FORMAT(ROUND(AVG(Accuracy), 1), '###.#') AS DECIMAL(4, 1)) AS MeanAccuracy,
	ROUND(MAX(Accuracy), 1) AS MaxAccuracy
FROM Models
JOIN ModelTypes ON Models.ModelTypeCd = ModelTypes.ModelTypeCd
WHERE ModelID NOT IN (SELECT ModelID FROM Assignments)
GROUP BY ModelTypeName
ORDER BY ModelTypeName ASC;

/* Q3. Create a query to list down details of employees who have assigned more than 1
models as solution to any single order. List down their full name by
concatenating first name and last name with a single space in between. Order
your results by employee’s full name. */

-- Reference for GROUP BY ... HAVING: https://learnsql.com/cookbook/how-to-find-duplicate-rows-in-sql/

SELECT 
	FirstName + ' ' + LastName AS FullName, 
	ContactNo AS Contact,
	Gender
FROM Employees 
WHERE EmployeeID IN (
	SELECT
		Assignments.EmployeeID
	FROM Assignments
	JOIN Employees ON Assignments.EmployeeID = Employees.EmployeeID
	GROUP BY OrderID, Assignments.EmployeeID
	HAVING COUNT(Assignments.EmployeeID) > 1)
ORDER BY FullName ASC;

/* Q4. Create a query to list down number of assignments fulfilling the Acceptance
Criteria stated in page 4. Display only the final count. */

SELECT 
	COUNT(*) AS NumberAccepted
FROM Assignments a
JOIN Orders o ON a.OrderID = o.OrderID
JOIN Models m ON a.ModelID = m.ModelID
LEFT JOIN OrderReqType rt ON a.OrderID = rt.OrderID
WHERE
	a.DateAssigned <= o.CompletionDate
		AND
	(rt.ModelTypeCd = m.ModelTypeCd 
	OR rt.ModelTypeCd IS NULL)
		AND
	m.Accuracy >= o.RequiredAccur;