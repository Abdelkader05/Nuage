-- Entreprises
INSERT INTO entreprise (nom, pays) VALUES
('Ubisoft', 'France'),
('Blizzard', 'USA'),
('EA', 'USA'),
('Bethesda', 'USA'),
('Nintendo', 'Japon');

-- Genres de jeux
INSERT INTO genre (nom_genre) VALUES
('Action'),
('RPG'),
('Stratégie'),
('Simulation'),
('Aventure');

-- Porte-monnaie
INSERT INTO porte_monnaie (solde) VALUES
(500),
(1000),
(1500),
(2000),
(800);

-- Joueurs
INSERT INTO joueur (pseudo, mdp, nom, mail, date_naissance, id_monnaie) VALUES
('Alice', 'alice123', 'Alice Dupont', 'alice@mail.com', '1990-01-01', 1),
('Bob', 'bob123', 'Bob Martin', 'bob@mail.com', '1992-02-02', 2),
('Charlie', 'charlie123', 'Charlie Brown', 'charlie@mail.com', '1985-03-03', 3),
('David', 'david123', 'David Smith', 'david@mail.com', '1995-04-04', 4),
('Eve', 'eve123', 'Eve Adams', 'eve@mail.com', '2000-05-05', 5);

-- Jeux
INSERT INTO jeu (titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev) VALUES
('Assassin''s Creed', 60.00, '2020-03-01', 18, 'Action aventure', 'Ubisoft', 'Ubisoft'),
('World of Warcraft', 40.00, '2004-11-23', 12, 'Jeu de rôle en ligne', 'Blizzard', 'Blizzard'),
('FIFA 21', 50.00, '2020-09-30', 3, 'Jeu de football', 'EA', 'EA'),
('Skyrim', 55.00, '2011-11-11', 16, 'Jeu de rôle en monde ouvert', 'Bethesda', 'Bethesda'),
('Super Mario Odyssey', 40.00, '2017-10-27', 3, 'Jeu d''aventure de plateforme', 'Nintendo', 'Nintendo');

-- Classer les jeux dans des genres
INSERT INTO classer (id_jeu, id_genre) VALUES
(1, 1),  -- Assassin's Creed est un jeu Action
(2, 2),  -- World of Warcraft est un RPG
(3, 3),  -- FIFA 21 est un jeu de Stratégie
(4, 2),  -- Skyrim est un RPG
(5, 4);  -- Super Mario Odyssey est un jeu d'Aventure

-- Succès pour les jeux
INSERT INTO succes (code, intitule, condition, id_jeu) VALUES
('S001', 'Finir le jeu', 'Terminer toutes les missions principales', 1),
('S002', 'Maître du jeu', 'Obtenir tous les succès', 2),
('S003', 'Champion', 'Gagner 100 matchs', 3),
('S004', 'Dragon Slayer', 'Tuer le dragon dans Skyrim', 4),
('S005', 'Explorateur', 'Visiter tous les niveaux de Mario Odyssey', 5);

-- Reapprovisionner (argent ajouté au porte-monnaie)
INSERT INTO reapprovisionner (pseudo, id_monnaie, date_transaction, montant) VALUES
('Alice', 1, '2024-11-01', 100),
('Bob', 2, '2024-11-05', 200),
('Charlie', 3, '2024-11-10', 300),
('David', 4, '2024-11-12', 400),
('Eve', 5, '2024-11-15', 150);

-- Achats de jeux
INSERT INTO achat (pseudo, id_jeu, note, commentaire, date_achat) VALUES
('Alice', 1, 4.5, 'Super jeu, j''adore!', '2024-11-02'),
('Bob', 2, 5.0, 'Le meilleur jeu de tous les temps!', '2024-11-06'),
('Charlie', 3, 3.0, 'Sympa mais répétitif.', '2024-11-12'),
('David', 4, 4.0, 'Jeu incroyable, mais trop long.', '2024-11-14'),
('Eve', 5, 4.8, 'Très fun, j''adore les mondes de Mario!', '2024-11-17');

-- Partages de jeux
INSERT INTO partage (pseudo1, pseudo2, id_jeu, date_partage) VALUES
('Alice', 'Bob', 1, '2024-11-02'),
('Bob', 'Charlie', 2, '2024-11-07'),
('Charlie', 'Alice', 3, '2024-11-13'),
('David', 'Eve', 4, '2024-11-15'),
('Eve', 'Alice', 5, '2024-11-18');

-- Déblocage de succès
INSERT INTO debloquer (pseudo, id_jeu, code, date_obtention) VALUES
('Alice', 1, 'S001', '2024-11-03'),
('Bob', 2, 'S002', '2024-11-08'),
('Charlie', 3, 'S003', '2024-11-14'),
('David', 4, 'S004', '2024-11-16'),
('Eve', 5, 'S005', '2024-11-19');

-- Ajout de transactions supplémentaires pour tester les cas
INSERT INTO reapprovisionner (pseudo, id_monnaie, date_transaction, montant) VALUES
('Alice', 1, '2024-11-20', 50),
('Bob', 2, '2024-11-21', 250),
('Charlie', 3, '2024-11-22', 350),
('David', 4, '2024-11-23', 500),
('Eve', 5, '2024-11-24', 100);

-- Ajout d'achats supplémentaires
INSERT INTO achat (pseudo, id_jeu, note, commentaire, date_achat) VALUES
('Alice', 2, 4.0, 'Je suis un peu déçu, trop de bugs.', '2024-11-05'),
('Bob', 1, 3.5, 'Trop compliqué pour moi.', '2024-11-07'),
('Charlie', 5, 4.9, 'Superbe expérience, très innovant.', '2024-11-15'),
('David', 3, 4.3, 'Très bon, mais manque de contenu.', '2024-11-18'),
('Eve', 4, 5.0, 'Un des meilleurs RPG que j''ai joués!', '2024-11-20');
