CREATE TABLE DEPARTMENT(
Department_id       INT       NOT NULL ,
Workers             VARCHAR   NOT NULL ,
Bulding_location    VARCHAR   NOT NULL ,
PRIMARY KEY(Department_id)
);


CREATE TABLE WORKER (
Worker_id     INT       NOT NULL ,
Name          VARCHAR   NOT NULL ,
Phone_number  VARCHAR   NOT NULL ,
Gender        VARCHAR   NOT NULL ,
Salary        VARCHAR   NOT NULL ,
PRIMARY KEY(Worker_id)
);


CREATE TABLE DOCTOR(
Doctor_id     INT        NOT NULL ,
Field         VARCHAR    NOT NULL ,
Degree        VARCHAR    NOT NULL ,
worker_id    INT        NOT NULL ,
Department_id INT        NOT NULL ,
PRIMARY KEY(Doctor_id,worker_id,Department_id),
FOREIGN KEY (worker_id) REFERENCES WORKER(Worker_id),
FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);


CREATE TABLE STUFF (
Stuff_id     INT        NOT NULL ,
Job_title    VARCHAR    NOT NULL ,
worker_id  VARCHAR    NOT NULL ,
PRIMARY KEY (Stuff_id,worker_id),
FOREIGN KEY (worker_id) REFERENCES WORKER(Worker_id)
);


CREATE TABLE MEDICATION (
Medication_id      INT       NOT NULL,
Doses              VARCHAR   NOT NULL,
Expiration_date    date      NOT NULL ,
PRIMARY KEY(Medication_id)
);


CREATE TABLE BILL (
Bill_ID             INT       NOT NULL,
Tests               VARCHAR   NOT NULL,
Tretment_type       VARCHAR   NOT NULL,
Time_Admitted       date      NOT NULL,
Prescription        VARCHAR   NOT NULL,
PRIMARY KEY(Bill_ID)
);



CREATE TABLE CAFETERIA (
Cafeteria_id       INT       NOT NULL,
Food_type          VARCHAR   NOT NULL,
Seating             VARCHAR   NOT NULL,
PRIMARY KEY(Cafeteria_id)
);


CREATE TABLE cafeteria_stuff(
Cafeteria_id    INT       NOT NULL,
Stuff_id        INT       NOT NULL ,
Position        VARCHAR   NOT NULL ,
PRIMARY KEY(Cafeteria_id,Stuff_id),
FOREIGN KEY (Cafeteria_id) REFERENCES CAFETERIA(Cafeteria_id),
FOREIGN KEY (Stuff_id) REFERENCES STUFF(Stuff_id)
);


CREATE TABLE PATIONT (
Pationt_id        INT       NOT NULL,
Contact_number    INT       NOT NULL,
Name       VARCHAR   NOT NULL,
Address       VARCHAR   NOT NULL,
Gender       VARCHAR   NOT NULL,
Age             INT       NOT NULL,
Blod_type       VARCHAR   NOT NULL,
Cafeteria_id    INT       NOT NULL,
Bill_ID             INT       NOT NULL,
PRIMARY KEY(Pationt_id,Cafeteria_id,Bill_ID),
FOREIGN KEY(Cafeteria_id) REFERENCES CAFETERIA(Cafeteria_id) ,
FOREIGN KEY(Bill_ID) REFERENCES BILL (Bill_ID)

);


CREATE TABLE MEDICATION_PRESCRIBED(
PRESCRIBED_id     INT       NOT NULL,
Medication_id     INT       NOT NULL,
Pationt_id        INT       NOT NULL,
PRIMARY KEY (PRESCRIBED_id,Medication_id,Pationt_id),
FOREIGN KEY (Medication_id) REFERENCES MEDICATION(Medication_id),
FOREIGN KEY (Pationt_id) REFERENCES PATIONT(Pationt_id)
);


CREATE TABLE DOCTOR_PATIONT(
Pationt_id    INT       NOT NULL,
Doctor_id     INT       NOT NULL ,
Time          date      NOT NULL,
PRIMARY KEY(Pationt_id,Doctor_id),
FOREIGN KEY (Pationt_id) REFERENCES PATIONT(Pationt_id),
FOREIGN KEY (Doctor_id) REFERENCES DOCTOR(Doctor_id)
);


CREATE TABLE DIAGNOSIS (
Illness     VARCHAR    NOT NULL ,
Pationt_id    INT       NOT NULL,
Doctor_id     INT       NOT NULL ,
PRIMARY KEY(Illness,Pationt_id,Doctor_id),
FOREIGN KEY (Pationt_id) REFERENCES PATIONT(Pationt_id),
FOREIGN KEY (Doctor_id) REFERENCES DOCTOR(Doctor_id)
);


CREATE TABLE TESTS (
Test_id       INT        NOT NULL,
Result        VARCHAR    NOT NULL ,
Illness       VARCHAR    NOT NULL ,
Pationt_id    INT        NOT NULL,
Doctor_id     INT        NOT NULL ,
PRIMARY KEY(Test_id,Illness,Pationt_id,Doctor_id),
FOREIGN KEY (Pationt_id) REFERENCES PATIONT(Pationt_id),
FOREIGN KEY (Doctor_id) REFERENCES DOCTOR(Doctor_id),
FOREIGN KEY (Illness) REFERENCES DIAGNOSIS(Illness)

);

INSERT INTO DEPARTMENT (Department_id, Workers, Bulding_location)
VALUES
(1, 'Department 1 Workers', 'Location 1'),
(2, 'Department 2 Workers', 'Location 2');

INSERT INTO WORKER (Worker_id, Name, Phone_number, Gender, Salary)
VALUES
(1, 'John Doe', '123-456-7890', 'Male', '50000'),
(2, 'Jane Smith', '987-654-3210', 'Female', '45000');

INSERT INTO DOCTOR (Doctor_id, Field, Degree, worker_id, Department_id)
VALUES
(1, 'Cardiology', 'MD', 1, 1),
(2, 'Orthopedics', 'MD', 2, 1);

INSERT INTO STUFF (Stuff_id, Job_title, worker_id)
VALUES
(1, 'Nurse', 3),
(2, 'Cafeteria Staff', 4);

INSERT INTO MEDICATION (Medication_id, Doses, Expiration_date)
VALUES
(1, '10mg', '2023-12-31'),
(2, '20mg', '2023-11-30');

INSERT INTO BILL (Bill_ID, Tests, Tretment_type, Time_Admitted, Prescription)
VALUES
(1, 'Blood Test', 'Inpatient', '2023-10-18', 'Medication 1'),
(2, 'X-ray', 'Outpatient', '2023-10-19', 'Medication 2');

INSERT INTO CAFETERIA (Cafeteria_id, Food_type, Seating)
VALUES
(1, 'Cafeteria 1 Food', 'Indoor'),
(2, 'Cafeteria 2 Food', 'Outdoor');

INSERT INTO cafeteria_stuff (Cafeteria_id, Stuff_id, Position)
VALUES
(1, 1, 'Nurse'),
(2, 2, 'Cafeteria Staff');


INSERT INTO PATIONT (Pationt_id, Contact_number, Name, Address, Gender, Age, Blod_type, Cafeteria_id, Bill_ID)
VALUES
(1, 1234567890, 'Patient 1', 'Address 1', 'Male', 35, 'A+', 1, 1),
(2, 9876543210, 'Patient 2', 'Address 2', 'Female', 45, 'B-', 2, 2);


INSERT INTO MEDICATION_PRESCRIBED (PRESCRIBED_id, Medication_id, Pationt_id)
VALUES
(1, 1, 1),
(2, 2, 2);


INSERT INTO DOCTOR_PATIONT (Pationt_id, Doctor_id, Time)
VALUES
(1, 1, '2023-10-18'),
(2, 2, '2023-10-19');


INSERT INTO DIAGNOSIS (Illness, Pationt_id, Doctor_id)
VALUES
('Fever', 1, 1),
('Fractured Arm', 2, 2);


INSERT INTO TESTS (Test_id, Result, Illness, Pationt_id, Doctor_id)
VALUES
(1, 'Positive', 'Fever', 1, 1),
(2, 'Fracture Confirmed', 'Fractured Arm', 2, 2);


SELECT COUNT(MP.Pationt_id) AS "pationt_count",
CASE WHEN M.Expiration_date < CURRENT_DATE THEN 'Active'
ELSE 'Expired' END AS Midication_Expierd_Or_Not
FROM MEDICATION AS M 
LEFT JOIN MEDICATION_PRESCRIBED AS MP
ON MP.Medication_id= M.Medication_id
GROUP BY M.Medication_id;
 


SELECT 
D.Doctor_id ,
D.Field ,
D.Degree ,
D.worker_id ,

DE.Department_id ,
DE.Workers  ,
DE.Bulding_location ,

P.Pationt_id,
P.Contact_number ,
P.Name ,
P.Address,
P.Gender,
P.Age ,
P.Blod_type ,
P.Cafeteria_id,
P.Bill_ID ,

DP.Time,

W.Name AS doctor_Name ,
w.Phone_number AS doctor_phone,
w.Gender AS doctor_gender,
w.Salary AS doctor_salary
FROM DOCTOR AS D

LEFT JOIN WORKER AS W
ON W.Worker_id=D.Worker_id

LEFT JOIN DOCTOR_PATIONT AS DP
ON DP.Doctor_id=D.doctor_id 

LEFT JOIN DEPARTMENT AS DE
ON DE.Department_id=D.Department_id

LEFT JOIN PATIONT AS P
ON P.Pationt_id=DP.Pationt_id

WHERE p.Age>12 AND DP.Time !=2022
ORDER by p.Name , W.Name DESC;
