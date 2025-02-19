CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Specializations (
    SpecializationID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE HealthInsurance (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    HealthName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Diagnoses (
    DiagnosisID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Manufacturer VARCHAR(100),
    PrescriptionRequired BOOLEAN
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    OfficeNumber INT,
    SpecializationID INT,
    WorksWithInsurance BOOLEAN,
    InsuranceID INT,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID),
    FOREIGN KEY (InsuranceID) REFERENCES HealthInsurance(InsuranceID)
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    EGN VARCHAR(10) UNIQUE,
    DoctorID INT,
    MedicationID INT,
    DiagnosisID INT,
    InsuranceID INT,
    PrescribedTreatment VARCHAR(255),
    TreatmentPeriod VARCHAR(50),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnoses(DiagnosisID),
    FOREIGN KEY (InsuranceID) REFERENCES HealthInsurance(InsuranceID)
);

CREATE TABLE Examinations (
    ExaminationID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    ExamDate DATE,
    ExamType VARCHAR(50),
    Results TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
