DROP TABLE IF EXISTS  entreprise CASCADE;
DROP TABLE IF EXISTS  genre CASCADE;
DROP TABLE IF EXISTS  porte_monnaie CASCADE;
DROP TABLE IF EXISTS  joueur CASCADE;
DROP TABLE IF EXISTS  jeu CASCADE;
DROP TABLE IF EXISTS  succes CASCADE;
DROP TABLE IF EXISTS  classer CASCADE;
DROP TABLE IF EXISTS  reapprovisionner CASCADE;
DROP TABLE IF EXISTS  achat CASCADE;
DROP TABLE IF EXISTS  partage CASCADE;
DROP TABLE IF EXISTS  debloquer CASCADE;

CREATE TABLE entreprise(
    nom varchar(20) PRIMARY KEY,
    pays varchar(20)
);

CREATE TABLE genre(
    id_genre serial PRIMARY KEY,
    nom_genre varchar(20) NOT NULL
);

CREATE TABLE porte_monnaie(
    id_monnaie serial PRIMARY KEY,
    solde int default 0 NOT NULL
);

CREATE TABLE joueur(
    pseudo varchar(20) PRIMARY KEY,
    mdp varchar(20) NOT NULL,
    nom varchar(30) NOT NULL,
    mail varchar(50) NOT NULL,
    date_naissance date NOT NULL,
    id_monnaie int ,
    FOREIGN KEY (id_monnaie) REFERENCES porte_monnaie(id_monnaie)
);

CREATE TABLE jeu(
    id_jeu serial PRIMARY KEY,
    titre varchar(50) NOT NULL, --On considére qu'un jeu n'a pas forcement un titre unique
    prix numeric(5, 2) default 0 NOT NULL,
    date_sortie date NOT NULL,
    age_min numeric(2, 0) NOT NULL,
    synopsis varchar(200), 
    nom_edite varchar(20), 
    nom_dev varchar(20),
    FOREIGN KEY (nom_edite) REFERENCES entreprise(nom),
    FOREIGN KEY (nom_dev) REFERENCES entreprise(nom)
);

CREATE TABLE succes(
    code varchar(4) PRIMARY KEY,
    intitule varchar(30) NOT NULL,
    condition varchar(100),
    id_jeu int,
    FOREIGN KEY (id_jeu) REFERENCES jeu(id_jeu)
);

CREATE TABLE classer(
    id_jeu int,
    id_genre int,
    PRIMARY KEY (id_jeu, id_genre),
    FOREIGN KEY (id_jeu) REFERENCES jeu(id_jeu),
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
);

CREATE TABLE reapprovisionner(
    id_reapprovision serial PRIMARY KEY,
    pseudo varchar(20) NOT NULL,
    id_monnaie int NOT NULL,
    date_transaction date NOT NULL,
    montant int NOT NULL,
    CONSTRAINT montant_min CHECK (montant > 0),
    FOREIGN KEY (pseudo) REFERENCES joueur(pseudo),
    FOREIGN KEY (id_monnaie) REFERENCES porte_monnaie(id_monnaie)
);

CREATE TABLE achat(
    pseudo varchar(20),
    id_jeu int,
    note numeric(2, 1), -- Note sur 5 
    commentaire text,
    date_achat date NOT NULL,
    PRIMARY KEY (pseudo, id_jeu),
    CONSTRAINT noteMAX CHECK (note <= 5),
    FOREIGN KEY (pseudo) REFERENCES joueur(pseudo),
    FOREIGN KEY (id_jeu) REFERENCES jeu(id_jeu)
);

CREATE TABLE partage(
    pseudo1 varchar(20),
    pseudo2 varchar(20),
    id_jeu int,
    date_partage date NOT NULL,
    PRIMARY KEY (pseudo1, pseudo2, id_jeu),
    FOREIGN KEY (pseudo1) REFERENCES joueur(pseudo),
    FOREIGN KEY (pseudo2) REFERENCES joueur(pseudo),
    FOREIGN KEY (id_jeu) REFERENCES jeu(id_jeu)
);

CREATE TABLE debloquer(
    pseudo varchar(20),
    id_jeu int,
    code varchar(4),
    date_obtention date NOT NULL,
    PRIMARY KEY (pseudo, id_jeu, code),
    FOREIGN KEY (pseudo) REFERENCES joueur(pseudo),
    FOREIGN KEY (id_jeu) REFERENCES jeu(id_jeu),
    FOREIGN KEY (code) REFERENCES succes(code)
);

CREATE VIEW rapport AS
(
    SELECT jour, nom_edite, titre, nb_vente, nb_partage,
           vente_jeu.nb_vente * jeu.prix AS chiffre_affaire, --le chiffre d’affaire réalisé
           moyenne_note, nb_succe
    FROM jeu NATURAL LEFT JOIN
    (
       SELECT id_jeu, date_achat AS jour, count(*) AS nb_vente, avg(note) AS moyenne_note
       FROM achat
       GROUP BY id_jeu, date_achat
    ) AS vente_jeu NATURAL LEFT JOIN
    (
        SELECT id_jeu, date_partage AS jour, count(*) AS nb_partage
        FROM partage
        GROUP BY id_jeu, date_partage
    ) AS partage_jeu NATURAL LEFT JOIN
    (
       SELECT id_jeu, date_obtention AS jour, count(*) AS nb_succe
       FROM debloquer
       GROUP BY id_jeu, date_obtention
    ) AS debloque_jeu 

);
