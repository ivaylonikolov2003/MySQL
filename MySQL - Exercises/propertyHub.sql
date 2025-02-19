
use propertyHub;
-- Таблица за служителите
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    position VARCHAR(255)
);

-- Таблица за плащания на заплати
CREATE TABLE salaryPayments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeId INT,
    salaryAmount DECIMAL(10, 2),
    monthlyBonus DECIMAL(10, 2),
    yearOfPayment YEAR,
    monthOfPayment INT,
    dateOfPayment DATE,
    FOREIGN KEY (employeeId) REFERENCES employees(id)
);

-- Таблица за сделките
CREATE TABLE deals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeId INT,
    dealDate DATE,
    paymentType VARCHAR(255),
    FOREIGN KEY (employeeId) REFERENCES employees(id)
);
-- Таблица за типовете на имотите
CREATE TABLE types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    typeName VARCHAR(255)
);

-- Таблица за клиентите
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(255)
);

-- Таблица за имотите
CREATE TABLE properties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    typeId INT,
    customerId INT,
    area DECIMAL(10, 2),
    price DECIMAL(10, 2),
    location VARCHAR(255),
    description TEXT,
    FOREIGN KEY (typeId) REFERENCES types(id),
    FOREIGN KEY (customerId) REFERENCES customers(id)
);
-- Таблица за обявите
CREATE TABLE ads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dealId INT,
    propertyId INT,
    publicationDate DATE,
    isActual BOOLEAN,
    FOREIGN KEY (dealId) REFERENCES deals(id),
    FOREIGN KEY (propertyId) REFERENCES properties(id)
);

-- Таблица за действия свързани с обявите
CREATE TABLE actions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    adId INT,
    actionType INT,
    FOREIGN KEY (adId) REFERENCES ads(id)
);



