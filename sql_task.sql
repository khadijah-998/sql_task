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




SELECT COUNT (*) AS count
FROM MEDICATION;

SELECT Expiration_date,
CASE 
WHEN Expiration_date <GETDATE() THEN 'Active'
ELSE 'Expired' END AS Midication_Expierd_Or_Not
FROM MEDICATION; 


SELECT 
    D.Doctor_id,
    D.Field,
    D.Degree,
    D.Worker_id,
    DE.Department_id,
    DE.Workers,
    DE.Building_location,
    DP.Patient_id,
    DP.Time,
    W.Name AS Doctor_Name,
    W.Phone_number AS Doctor_Phone,
    W.Gender AS Doctor_Gender,
    W.Salary AS Doctor_Salary
FROM 
    DOCTOR D, WORKER W, DOCTOR_PATIENT DP, DEPARTMENT DE
WHERE 
    D.Worker_id = W.Worker_id
    AND D.Doctor_id = DP.Doctor_id
    AND D.Department_id = DE.Department_id
    AND P.Age > 12
    AND DP.Time <> 2022
ORDER BY 
    P.Name ASC, W.Name DESC;