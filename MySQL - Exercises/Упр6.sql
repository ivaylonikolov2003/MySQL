drop database if exists hospital2;
create database hospital2;
use hospital2;

create table specialization(
id int auto_increment primary key,
specName varchar(255) not null
);

create table healthInsurance(
idInsurance int auto_increment primary key,
healthName varchar(255) not null,
phoneNumber varchar(20) not null,
email varchar(25) not null
);

create table diagnoses(
diagnosisId int auto_increment primary key,
diagName varchar(255) not null
);

create table Medications(
medId int auto_increment primary key,
medName varchar(255) not null,
manufacture varchar(100),
prescriptionRequired boolean
);

create table doctors(
docId int auto_increment primary key,
FirstName varchar(50) not null,
SecondName varchar(50) not null,
LastName varchar(50) not null,
OfficeNum int,
specializationId int,
WorksWithInsurance boolean,
InsuranceId int,
TelNumber varchar(20),
Email varchar(100),
constraint foreign key (specializationId) references specialization(id),
constraint foreign key (InsuranceId) references healthInsurance(idInsurance)
);

create table patients(
patientId int auto_increment primary key,
FirstName varchar(50) not null,
SecondName varchar(50) not null,
LastName varchar(50) not null,
Address varchar(100),
Egn varchar(10) not null unique,
DoctorId int,
MedicationsId int,
DiagnosesId int,
InsuranceId int,
PrescribedTreatment VARCHAR(255),
TreatmentPeriod VARCHAR(50),
constraint foreign key (DoctorId) references doctors(docId),
constraint foreign key (MedicationsId) references Medications(medId),
constraint foreign key (DiagnosesId) references diagnoses(diagnosisId),
constraint foreign key (InsuranceId) references healthInsurance(idInsurance)
);