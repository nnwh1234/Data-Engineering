CREATE TABLE Customers (
	CustomerID CHAR(5) PRIMARY KEY NOT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	ContactNo CHAR(8) NOT NULL,
	CompanyName VARCHAR(300) NOT NULL
);

CREATE TABLE Employees (
	EmployeeID CHAR(5) PRIMARY KEY NOT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	ContactNo CHAR(9) NOT NULL,
	Gender CHAR(1) NOT NULL
);

CREATE TABLE ModelTypes (
	ModelTypeCd VARCHAR(8) PRIMARY KEY NOT NULL,
	ModelTypeName VARCHAR(200) NOT NULL
);

CREATE TABLE Datasets (
	DatasetID VARCHAR(4) PRIMARY KEY NOT NULL,
	DatasetName VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
	OrderID VARCHAR(8) PRIMARY KEY NOT NULL,
	OrderDate DATE NOT NULL,
	CompletionDate DATE NOT NULL,
	RequiredAccur DECIMAL(4,1) NOT NULL,
	CustomerID CHAR(5) NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderReqType (
	OrderID VARCHAR(8) NOT NULL,
	ModelTypeCd VARCHAR(8) NOT NULL,
	PRIMARY KEY (OrderID, ModelTypeCd),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (ModelTypeCd) REFERENCES ModelTypes(ModelTypeCd)
);

CREATE TABLE Models (
	ModelID CHAR(5) PRIMARY KEY NOT NULL,
	TrainingDate DATE NOT NULL,
	Accuracy DECIMAL(4,1) NOT NULL,
	ParentModelID CHAR(5) NULL,
	DatasetID VARCHAR(4) NOT NULL,
	ModelTypeCd VARCHAR(8) NOT NULL,
	FOREIGN KEY (ParentModelID) REFERENCES Models(ModelID),
	FOREIGN KEY (DatasetID) REFERENCES Datasets(DatasetID),
	FOREIGN KEY (ModelTypeCd) REFERENCES ModelTypes(ModelTypeCd)
);

CREATE TABLE Assignments (
	OrderID VARCHAR(8) NOT NULL,
	EmployeeID CHAR(5) NOT NULL,
	ModelID CHAR(5) NOT NULL,
	DateAssigned DATE NOT NULL,
	PRIMARY KEY (OrderID, EmployeeID, ModelID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
	FOREIGN KEY (ModelID) REFERENCES Models(ModelID)
);

INSERT INTO Customers VALUES
('c1231', 'Macie','Chew', 21313445, 'Power AI Ltd.'),
('c2231', 'June', 'Gu', 23591312, 'Fish and Dogs'),
('c3231', 'Miller', 'Wu', 34513265, 'Smart Commute'),
('c4231', 'Paul', 'Halim', 11390442, 'B&C Furniture'),
('c5231', 'Bella', 'Tan', 75813435, 'City Drainage'),
('c6231', 'Kiara', 'Sakura', 24634521, 'City Power'),
('c7231', 'Bowen', 'Han', 75643524, 'Country Development');

INSERT INTO Datasets (DatasetName, DatasetID) VALUES 
('Adult', 'd1'),
('River', 'd2'),
('Arizona', 'd3'),
('Vermont', 'd4'),
('Covertype', 'd5'),
('Iris', 'd6');

INSERT INTO Employees VALUES
('s1111', 'Peter', 'Phua', 142524124, 'M'),
('s2222', 'George', 'Mason', 344324251, 'M'),
('s3333', 'Francis', 'Lee', 234235246, 'M'),
('s4444', 'Alice', 'Wong', 324567342, 'F'),
('s5555', 'William', 'Chong', 893456114, 'M'),
('s6666', 'Brilliant', 'Dior', 907456251, 'F');

INSERT INTO ModelTypes VALUES
('DT', 'Decision Tree'),
('NN', 'Neural Network'),
('LogR', 'Logistic Regression'),
('RF', 'Random Forest'),
('SVM', 'Support Vector Machine'),
('NB', 'Naive Bayes'),
('LR', 'Linear Regression'),
('kNN', 'k-Nearest Neighbour');

INSERT INTO Orders (OrderID, OrderDate, CompletionDate, RequiredAccur, CustomerID) VALUES
('o080214', '2024-04-21', '2024-04-22', 70.0, 'c5231'),
('o241134', '2024-05-01', '2024-07-01', 99.9, 'c7231'),
('o214132', '2024-04-08', '2024-05-01', 50.0, 'c7231'),
('o174143', '2024-04-14', '2024-04-18', 70.0, 'c7231'),
('o22031', '2024-04-05', '2024-04-27', 50.0, 'c2231'),
('o31421', '2024-04-11', '2025-01-01', 1.0, 'c6231'),
('o00001', '2024-05-02', '2024-05-31', 60.0, 'c1231'),
('o11213', '2024-04-03', '2024-04-11', 80.0, 'c1231'),
('o12345', '2024-04-05', '2024-06-30', 77.0, 'c3231'),
('o12346', '2024-04-05', '2024-04-30', 56.0, 'c3231');

INSERT INTO OrderReqType VALUES
('o080214', 'DT'),
('o00001', 'SVM'),
('o00001', 'RF'),
('o11213', 'SVM');

INSERT INTO Models (ModelID, ModelTypeCd, TrainingDate, Accuracy, ParentModelID, DatasetID) VALUES 
('m1000', 'DT', '2024-01-01', 95.6, NULL, 'd1'),
('m1001', 'LR', '2024-01-05', 60.4, NULL, 'd2'),
('m1002', 'RF', '2024-01-07', 95.3, NULL, 'd3'),
('m1003', 'DT', '2024-01-08', 53.2, NULL, 'd4'),
('m1004', 'LR', '2024-01-11', 52.9, NULL, 'd2'),
('m1005', 'LR', '2024-01-15', 91.7, 'm1001', 'd5'),
('m1006', 'RF', '2024-01-17', 85.7, NULL, 'd3'),
('m1007', 'kNN', '2024-01-22', 85.7, NULL, 'd5'),
('m1008', 'SVM', '2024-01-23', 50.6, NULL, 'd3'),
('m1009', 'kNN', '2024-01-24', 51.9, 'm1007', 'd2'),
('m1010', 'DT', '2024-01-27', 93.7, 'm1003', 'd2'),
('m1011', 'SVM', '2024-01-30', 83.1, NULL, 'd4'),
('m1012', 'SVM', '2024-02-06', 97.6, 'm1011', 'd2'),
('m1013', 'kNN', '2024-02-07', 90.3, 'm1009', 'd2'),
('m1014', 'kNN', '2024-02-08', 59.3, NULL, 'd2'),
('m1015', 'RF', '2024-02-12', 59.4, 'm1006', 'd6'),
('m1016', 'NB', '2024-03-04', 70.6, NULL, 'd3'),
('m1017', 'NN', '2024-03-06', 95.5, NULL, 'd6'),
('m1018', 'LogR', '2024-03-12', 54.1, NULL, 'd2'),
('m1019', 'NN', '2024-03-15', 96.8, NULL, 'd6'),
('m1020', 'NN', '2024-03-17', 85.5, 'm1019', 'd4'),
('m1021', 'LogR', '2024-03-21', 60.2, NULL, 'd5'),
('m1022', 'RF', '2024-03-22', 67.1, NULL, 'd4'),
('m1023', 'NN', '2024-03-27', 90.5, 'm1020', 'd6'),
('m1024', 'RF', '2024-03-28', 85.9, 'm1015', 'd3');

INSERT INTO Assignments (OrderID, ModelID, EmployeeID, DateAssigned) VALUES 
('o080214', 'm1018', 's2222', '2024-04-22'),
('o080214', 'm1003', 's3333', '2024-04-22'),
('o080214', 'm1010', 's4444', '2024-04-22'),
('o214132', 'm1021', 's5555', '2024-04-09'),
('o174143', 'm1008', 's4444', '2024-04-14'),
('o22031', 'm1013', 's1111', '2024-04-11'),
('o22031', 'm1013', 's3333', '2024-04-12'),
('o22031', 'm1013', 's2222', '2024-04-15'),
('o22031', 'm1013', 's4444', '2024-04-07'),
('o22031', 'm1013', 's6666', '2024-04-27'),
('o22031', 'm1013', 's5555', '2024-04-28'),
('o22031', 'm1022', 's1111', '2024-04-19'),
('o31421', 'm1001', 's2222', '2024-04-15'),
('o31421', 'm1002', 's2222', '2024-04-15'),
('o00001', 'm1012', 's1111', '2024-05-02'),
('o00001', 'm1022', 's6666', '2024-05-02'),
('o00001', 'm1013', 's5555', '2024-05-02'),
('o11213', 'm1003', 's3333', '2024-04-10'),
('o11213', 'm1011', 's3333', '2024-04-08'),
('o11213', 'm1012', 's3333', '2024-04-09'),
('o11213', 'm1012', 's4444', '2024-04-04'),
('o12345', 'm1018', 's1111', '2024-05-31'),
('o12345', 'm1019', 's3333', '2024-05-31'),
('o12346', 'm1015', 's2222', '2024-05-31'),
('o12346', 'm1023', 's4444', '2024-05-31'),
('o12346', 'm1021', 's6666', '2024-05-31');