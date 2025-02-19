use hospital;

INSERT INTO Specializations (Name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Dermatology');

INSERT INTO HealthInsurance (HealthName, PhoneNumber, Email) VALUES
('ABC Health Insurance', '123-456-7890', 'info@abchealth.com'),
('XYZ Health Insurance', '987-654-3210', 'info@xyzhealth.com');

INSERT INTO Diagnoses (Name) VALUES
('Hypertension'),
('Migraine'),
('Fracture'),
('Eczema');


INSERT INTO Medications (Name, Description, Manufacturer, PrescriptionRequired) VALUES
('Lisinopril', 'Blood pressure medication', 'PharmaCorp', true),
('Sumatriptan', 'Migraine relief medication', 'MediPharm', true),
('Ibuprofen', 'Pain and inflammation relief', 'Generic Pharma', false),
('Hydrocortisone Cream', 'Topical steroid for skin inflammation', 'DermiCare', false);


INSERT INTO Doctors (FirstName, LastName, SpecializationID, WorksWithInsurance, InsuranceID, PhoneNumber, Email) VALUES
('John', 'Smith', 1, true, 1, '555-1234', 'john.smith@example.com'),
('Emily', 'Johnson', 2, true, 2, '555-5678', 'emily.johnson@example.com'),
('Michael', 'Williams', 3, false, NULL, '555-9012', 'michael.williams@example.com'),
('Sarah', 'Brown', 4, true, 1, '555-3456', 'sarah.brown@example.com');

INSERT INTO Patients (FirstName, LastName, Address, EGN, DoctorID, MedicationID, DiagnosisID, InsuranceID, PrescribedTreatment, TreatmentPeriod) VALUES
('Alice', 'Jones', '123 Maple St', '1234567890', 1, 1, 1, 1, 'Take medication daily', '2 weeks'),
('Bob', 'Davis', '456 Oak St', '0987654321', 2, 2, 2, 2, 'Use medication as needed', '1 month'),
('Charlie', 'Wilson', '789 Elm St', '1357924680', 3, 3, 3, NULL, 'Rest and ice application', '3 weeks'),
('Diana', 'Miller', '987 Pine St', '2468013579', 4, 4, 4, 1, 'Apply cream twice daily', '4 weeks');

INSERT INTO Examinations (PatientID, DoctorID, ExamDate, ExamType, Results) VALUES
(1, 1, '2024-03-20', 'Checkup', 'Blood pressure slightly elevated'),
(2, 2, '2024-03-21', 'MRI', 'No abnormalities detected'),
(3, 3, '2024-03-22', 'X-Ray', 'Confirmed fracture in right arm'),
(4, 4, '2024-03-23', 'Skin Biopsy', 'Positive for eczema');

select Patients.FirstName, Patients.LastName, Doctors.FirstName, Doctors.LastName, Specializations.Name, Diagnoses.Name
FROM Patients
JOIN Doctors ON Doctors.DoctorId = Patients.DoctorId
JOIN Specializations ON Specializations.SpecializationId = Doctors.SpecializationId
JOIN Diagnoses ON Patients.DiagnosisId = Diagnoses.DiagnosisId
ORDER BY Patients.LastName DESC;

select patients.FirstName, patients.LastName, examinations.ExamDate, examinations.ExamType, doctors.FirstName, doctors.LastName, specializations.Name
from patients
join doctors on doctors.DoctorId = patients.DoctorId
join examinations on patients.patientId = examinations.patientId
join specializations on doctors.specializationId = specializations.specializationId
order by examinations.ExamDate;

select patients.FirstName, patients.LastName, medications.Name, healthinsurance.healthName, healthinsurance.email
from patients
join healthinsurance on patients.InsuranceId = healthinsurance.InsuranceId
join medications on patients.MedicationId = medications.MedicationId
order by patients.FirstName;

select doctors.FirstName, doctors.LastName, specializations.Name, count(patients.patientId) as TotalPatients
from doctors
join patients on doctors.DoctorId = patients.DoctorId
join specializations on doctors.specializationId = specializations.specializationId
group by doctors.DoctorId
order by TotalPatients desc;

select doctors.FirstName, doctors.LastName, specializations.Name, avg(year(current_date()) - year(str_to_date(patients.egn, '%Y%m%d'))) as AvgAge
from doctors
join patients on doctors.DoctorId = patients.DoctorId
join specializations on doctors.specializationId = specializations.specializationId
group by doctors.DoctorId
order by AvgAge asc;

select doctors.FirstName, doctors.LastName, specializations.Name, count(Examinations.ExaminationID) as TotalExamination
from doctors
join examinations on doctors.DoctorId = Examinations.ExaminationID
join specializations on doctors.specializationId = specializations.specializationId
group by doctors.DoctorId
order by TotalExamination desc;