-- Suppression des tables (dans l'ordre inverse de création)
DROP TABLE Marquage;
DROP TABLE Balise;
DROP TABLE Commentaire;
DROP TABLE Utilisation;
DROP TABLE Createur_Appareil;
DROP TABLE Createur;
DROP TABLE Lignage;
DROP TABLE Lieu;
DROP TABLE Temps;
DROP TABLE Photographie;
DROP TABLE Configuration;
DROP TABLE Appareil;
DROP TABLE Utilisateur;

-- Création des tables
CREATE TABLE Utilisateur (
    IDUTIL NUMBER PRIMARY KEY,
    NOM VARCHAR2(50),
    PRENOM VARCHAR2(50)
);

CREATE TABLE Appareil (
    IDAPP NUMBER PRIMARY KEY,
    MARQUE VARCHAR2(50)
);

CREATE TABLE Configuration (
    IDCONF NUMBER PRIMARY KEY,
    OUVERTURE_FOCALE VARCHAR2(50),
    TEMPS_EXPO VARCHAR2(50),
    FLASH NUMBER
);

CREATE TABLE Photographie (
    CODE NUMBER PRIMARY KEY,
    LIEU_REALISATION VARCHAR2(50),
    DATE_REALISATION DATE,
    LICENCE VARCHAR2(50),
    IDAPPAREIL NUMBER,
    IDCONF NUMBER,
    IDUTIL_PUB NUMBER,
    FOREIGN KEY (IDAPPAREIL) REFERENCES Appareil(IDAPP),
    FOREIGN KEY (IDCONF) REFERENCES Configuration(IDCONF),
    FOREIGN KEY (IDUTIL_PUB) REFERENCES Utilisateur(IDUTIL)
);

CREATE TABLE Temps (
    DATES VARCHAR(255) PRIMARY KEY,
    ANNEE NUMBER,
    MOIS NUMBER,
    JOUR NUMBER
);

CREATE TABLE Lieu (
    LIEU VARCHAR2(50) PRIMARY KEY
);

CREATE TABLE Lignage (
    MODELE VARCHAR2(50) PRIMARY KEY,
    Ligne_parente VARCHAR2(50),
    FOREIGN KEY (Ligne_parente) REFERENCES Lignage(MODELE)
);

CREATE TABLE Createur (
    CREATEUR VARCHAR2(50) PRIMARY KEY
);

CREATE TABLE Createur_Appareil (
    CREATEUR VARCHAR2(50),
    IDAPP NUMBER,
    PRIMARY KEY (CREATEUR, IDAPP),
    FOREIGN KEY (CREATEUR) REFERENCES Createur(CREATEUR),
    FOREIGN KEY (IDAPP) REFERENCES Appareil(IDAPP)
);

CREATE TABLE Utilisation (
    IDDIS NUMBER PRIMARY KEY,
    CODEPHOTOPUB NUMBER,
    IDUTIL_VIS NUMBER,
    IDALB NUMBER,
    IDGAL NUMBER,
    ID_UTIL_LIKE NUMBER,
    IDUTIL_ABON_1 NUMBER,
    IDUTIL_ABON_2 NUMBER,
    FOREIGN KEY (CODEPHOTOPUB) REFERENCES Photographie(CODE),
    FOREIGN KEY (IDUTIL_VIS) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (IDALB) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (IDGAL) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (IDDIS) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (ID_UTIL_LIKE) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (IDUTIL_ABON_1) REFERENCES Utilisateur(IDUTIL),
    FOREIGN KEY (IDUTIL_ABON_2) REFERENCES Utilisateur(IDUTIL)
);

CREATE TABLE Commentaire (
    IDCOMMENTAIRE NUMBER PRIMARY KEY,
    ID_UTILISATION NUMBER, 
    TEXTECOMMENTAIRE VARCHAR2(200),
    CODEPHOTOCOM NUMBER,
    IDUTIL_COM NUMBER,
    FOREIGN KEY (ID_UTILISATION) REFERENCES Utilisation(IDDIS), 
    FOREIGN KEY (CODEPHOTOCOM) REFERENCES Photographie(CODE),
    FOREIGN KEY (IDUTIL_COM) REFERENCES Utilisateur(IDUTIL)
);

CREATE TABLE Balise (
    TYPE_BALISE VARCHAR2(50) PRIMARY KEY
);

CREATE TABLE Marquage (
    BALISE_MARQUER VARCHAR2(50),
    CODEPHOTOMAR NUMBER,
    IDUTIL_MAR NUMBER,
    PRIMARY KEY (BALISE_MARQUER, CODEPHOTOMAR, IDUTIL_MAR),
    FOREIGN KEY (BALISE_MARQUER) REFERENCES Balise(TYPE_BALISE),
    FOREIGN KEY (CODEPHOTOMAR) REFERENCES Photographie(CODE),
    FOREIGN KEY (IDUTIL_MAR) REFERENCES Utilisateur(IDUTIL)
);

-- Ajout d'exemples d'utilisateurs
INSERT INTO Utilisateur VALUES (1, 'Smith', 'John');
INSERT INTO Utilisateur VALUES (2, 'Doe', 'Jane');
INSERT INTO Utilisateur VALUES (3, 'Johnson', 'Alice');
INSERT INTO Utilisateur VALUES (4, 'Williams', 'Robert');
INSERT INTO Utilisateur VALUES (5, 'Brown', 'Emily');
INSERT INTO Utilisateur VALUES (6, 'Miller', 'David');
INSERT INTO Utilisateur VALUES (7, 'Anderson', 'Sophie');
INSERT INTO Utilisateur VALUES (8, 'Davis', 'Michael');
INSERT INTO Utilisateur VALUES (9, 'Clark', 'Olivia');
INSERT INTO Utilisateur VALUES (10, 'Lee', 'Daniel');

-- Ajout d'exemples d'appareils photo
INSERT INTO Appareil VALUES (1, 'Nikon D3100');
INSERT INTO Appareil VALUES (2, 'Nikon D3200');
INSERT INTO Appareil VALUES (3, 'Canon EOS Rebel T6');
INSERT INTO Appareil VALUES (4, 'Sony Alpha A6000');
INSERT INTO Appareil VALUES (5, 'Canon EOS Rebel T5');
INSERT INTO Appareil VALUES (6, 'Sony Alpha A7III');
INSERT INTO Appareil VALUES (7, 'Nikon Z5');
INSERT INTO Appareil VALUES (8, 'Canon EOS 5D Mark IV');
INSERT INTO Appareil VALUES (9, 'Nikon Z6');
INSERT INTO Appareil VALUES (10, 'Olympus OM-D E-M1 Mark III');

-- Ajout d'exemples de configurations
INSERT INTO Configuration VALUES (1, 'f/2.8', '1/1000', 0);
INSERT INTO Configuration VALUES (2, 'f/3.5', '1/500', 1);
INSERT INTO Configuration VALUES (3, 'f/2.0', '1/800', 1);
INSERT INTO Configuration VALUES (4, 'f/4.0', '1/200', 0);
INSERT INTO Configuration VALUES (5, 'f/1.8', '1/500', 1);
INSERT INTO Configuration VALUES (6, 'f/2.0', '1/1000', 1);
INSERT INTO Configuration VALUES (7, 'f/4.5', '1/200', 0);
INSERT INTO Configuration VALUES (8, 'f/2.8', '1/800', 1);
INSERT INTO Configuration VALUES (9, 'f/1.4', '1/320', 1);
INSERT INTO Configuration VALUES (10, 'f/5.6', '1/125', 0);

-- Ajout d'exemples de photographies
INSERT INTO Photographie VALUES (1, 'Paris', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'CC BY-SA', 1, 1, 1);
INSERT INTO Photographie VALUES (2, 'New York', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'CC BY', 2, 2, 2);
INSERT INTO Photographie VALUES (3, 'Tokyo', TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'CC BY', 3, 3, 3);
INSERT INTO Photographie VALUES (4, 'London', TO_DATE('2023-04-25', 'YYYY-MM-DD'), 'All Rights Reserved', 4, 4, 4);
INSERT INTO Photographie VALUES (5, 'London', TO_DATE('2023-04-22', 'YYYY-MM-DD'), 'All Rights Reserved', 1, 2, 2);
INSERT INTO Photographie VALUES (6, 'Sydney', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 'CC BY', 6, 5, 5);
INSERT INTO Photographie VALUES (7, 'Rome', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'All Rights Reserved', 7, 7, 6);
INSERT INTO Photographie VALUES (8, 'Paris', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'CC BY-SA', 8, 8, 7);
INSERT INTO Photographie VALUES (9, 'New York', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'CC BY', 9, 9, 8);
INSERT INTO Photographie VALUES (10, 'Tokyo', TO_DATE('2023-09-25', 'YYYY-MM-DD'), 'All Rights Reserved', 10, 10, 9);
INSERT INTO Photographie VALUES (11, 'London', TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'CC BY', 1, 1, 10);
INSERT INTO Photographie VALUES (12, 'Sydney', TO_DATE('2023-11-12', 'YYYY-MM-DD'), 'CC BY-SA', 2, 2, 1);
INSERT INTO Photographie VALUES (13, 'Rome', TO_DATE('2023-12-05', 'YYYY-MM-DD'), 'All Rights Reserved', 3, 3, 2);
INSERT INTO Photographie VALUES (14, 'Paris', TO_DATE('2024-01-08', 'YYYY-MM-DD'), 'CC BY-SA', 4, 4, 3);
INSERT INTO Photographie VALUES (15, 'New York', TO_DATE('2024-02-14', 'YYYY-MM-DD'), 'CC BY', 5, 5, 4);

-- Ajout d'exemples de temps
INSERT INTO Temps VALUES ('2023-01-15', 2023, 1, 15);
INSERT INTO Temps VALUES ('2023-02-20', 2023, 2, 20);
INSERT INTO Temps VALUES ('2023-03-10', 2023, 3, 10);
INSERT INTO Temps VALUES ('2023-04-25', 2023, 4, 25);

-- Ajout d'exemples de lieux
INSERT INTO Lieu VALUES ('Paris');
INSERT INTO Lieu VALUES ('New York');
INSERT INTO Lieu VALUES ('Tokyo');
INSERT INTO Lieu VALUES ('London');
INSERT INTO Lieu VALUES ('Sydney');
INSERT INTO Lieu VALUES ('Rome');

-- Ajout d'exemples de lignages
INSERT INTO Lignage VALUES ('Nikon D3100', NULL);
INSERT INTO Lignage VALUES ('Nikon D3200', 'Nikon D3100');
INSERT INTO Lignage VALUES ('Canon EOS Rebel T5', NULL);
INSERT INTO Lignage VALUES ('Sony Alpha A6000', NULL);
INSERT INTO Lignage VALUES ('Canon EOS Rebel T6', 'Canon EOS Rebel T5');
INSERT INTO Lignage VALUES ('Nikon Z5', NULL);
INSERT INTO Lignage VALUES ('Nikon Z6', 'Nikon Z5');



-- Ajout d'exemples de créateurs
INSERT INTO Createur VALUES ('Eiji Fumio');
INSERT INTO Createur VALUES ('Alice Johnson');
INSERT INTO Createur VALUES ('Robert Williams');
INSERT INTO Createur VALUES ('Sophie Turner');
INSERT INTO Createur VALUES ('David Miller');
INSERT INTO Createur VALUES ('Olivia Clark');

-- Ajout d'exemples d'association entre créateurs et appareils
INSERT INTO Createur_Appareil VALUES ('Alice Johnson', 1);
INSERT INTO Createur_Appareil VALUES ('Eiji Fumio', 2);
INSERT INTO Createur_Appareil VALUES ('Robert Williams', 2);
INSERT INTO Createur_Appareil VALUES ('Eiji Fumio', 3);
INSERT INTO Createur_Appareil VALUES ('Alice Johnson', 4);
INSERT INTO Createur_Appareil VALUES ('Sophie Turner', 5);
INSERT INTO Createur_Appareil VALUES ('Olivia Clark', 6);
INSERT INTO Createur_Appareil VALUES ('David Miller', 7);
INSERT INTO Createur_Appareil VALUES ('David Miller', 8);
INSERT INTO Createur_Appareil VALUES ('Alice Johnson', 9);
INSERT INTO Createur_Appareil VALUES ('Sophie Turner', 10);
INSERT INTO Createur_Appareil VALUES ('Olivia Clark', 10);



-- Ajout d'exemples de balises
INSERT INTO Balise VALUES ('Cityscape');
INSERT INTO Balise VALUES ('Travel');
INSERT INTO Balise VALUES ('Street Photography');
INSERT INTO Balise VALUES ('Architecture');
INSERT INTO Balise VALUES ('Portrait');
INSERT INTO Balise VALUES ('Nature');
INSERT INTO Balise VALUES ('Wildlife');
INSERT INTO Balise VALUES ('Abstract');

-- Ajout d'exemples de marquages
INSERT INTO Marquage VALUES ('Cityscape', 1, 1);
INSERT INTO Marquage VALUES ('Travel', 2, 2);
INSERT INTO Marquage VALUES ('Street Photography', 3, 3);
INSERT INTO Marquage VALUES ('Architecture', 4, 4);
INSERT INTO Marquage VALUES ('Portrait', 6, 5);
INSERT INTO Marquage VALUES ('Nature', 7, 7);
INSERT INTO Marquage VALUES ('Wildlife', 8, 8);
INSERT INTO Marquage VALUES ('Abstract', 9, 9);

