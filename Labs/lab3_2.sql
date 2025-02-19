CREATE DATABASE autoService;

CREATE TABLE Services (
  ServiceID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Description TEXT,
  Price DECIMAL(10,2) NOT NULL,
  CompletionTime INT NOT NULL
);
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  PhoneNumber VARCHAR(15) NOT NULL,
  Address TEXT
);
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Position VARCHAR(255) NOT NULL
);
CREATE TABLE Cars (
  CarID INT PRIMARY KEY,
  LicensePlateNumber VARCHAR(10) NOT NULL,
  Make VARCHAR(255) NOT NULL,
  Model VARCHAR(255) NOT NULL,
  YearOfManufacture INT NOT NULL,
  CustomerID INT NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Repairs (
  RepairID INT PRIMARY KEY,
  Date DATE NOT NULL,
  CarID INT NOT NULL,
  CustomerID INT NOT NULL,
  EmployeeID INT NOT NULL,
  ProblemDescription TEXT,
  PerformedServices VARCHAR(255) NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  Paid BOOLEAN NOT NULL,
  FOREIGN KEY (CarID) REFERENCES Cars(CarID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

