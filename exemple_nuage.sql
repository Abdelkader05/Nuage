-- Insertion dans la table entreprise (ajouter des développeurs et éditeurs nécessaires)
INSERT INTO entreprise (nom, pays) VALUES 
('Ubisoft', 'France'),
('EA Games', 'USA'),
('Nintendo', 'Japan'),
('Activision', 'USA'),
('Square Enix', 'Japan'),
('Rockstar Games', 'USA'),
('Bethesda', 'USA'),
('Capcom', 'Japan'),
('CD Projekt', 'Poland'),
('Bandai Namco', 'Japan'),
('Treyarch', 'USA'); -- Ajout de Treyarch pour résoudre l'erreur de clé étrangère

-- Insertion dans la table genre
INSERT INTO genre (nom_genre) VALUES 
('Action'),
('Aventure'),
('RPG'),
('Simulation'),
('Stratégie'),
('FPS'),
('Horreur'),
('MMO'),
('Puzzle'),
('Course'),
('Musique'),
('Survie'),
('Sport'),
('Combat'),
('Indie');

-- Insertion dans la table porte_monnaie
INSERT INTO porte_monnaie (solde) VALUES 
(100), (200), (150), (300), (250),
(120), (180), (220), (50), (500),
(300), (600), (700), (90), (200);

-- Insertion dans la table joueur
INSERT INTO joueur (pseudo, mdp, nom, mail, date_naissance, id_monnaie) VALUES 
('Player1', 'password1', 'Alice', 'alice@example.com', '1990-04-12', 1),
('Player2', 'password2', 'Bob', 'bob@example.com', '1992-07-24', 2),
('Player3', 'password3', 'Charlie', 'charlie@example.com', '1995-09-05', 3),
('Player4', 'password4', 'David', 'david@example.com', '1988-11-15', 4),
('Player5', 'password5', 'Eve', 'eve@example.com', '1991-03-25', 5),
('Player6', 'password6', 'Frank', 'frank@example.com', '1985-07-30', 6),
('Player7', 'password7', 'Grace', 'grace@example.com', '1998-05-20', 7),
('Player8', 'password8', 'Hannah', 'hannah@example.com', '1994-12-01', 8),
('Player9', 'password9', 'Ivy', 'ivy@example.com', '2000-01-11', 9),
('Player10', 'password10', 'Jack', 'jack@example.com', '1996-09-05', 10),
('Player11', 'password11', 'Kenny', 'kenny@example.com', '1993-10-19', 11),
('Player12', 'password12', 'Liam', 'liam@example.com', '1997-08-22', 12),
('Player13', 'password13', 'Mia', 'mia@example.com', '2002-05-15', 13),
('Player14', 'password14', 'Noah', 'noah@example.com', '1999-12-04', 14),
('Player15', 'password15', 'Olivia', 'olivia@example.com', '1992-06-25', 15);

-- Insertion dans la table jeu
INSERT INTO jeu (titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev) VALUES 
('Assassin''s Creed', 59.99, '2023-10-20', 18, 'Un jeu d''action dans un monde ouvert.', 'Ubisoft', 'Ubisoft'),
('The Sims', 39.99, '2023-05-15', 12, 'Simulation de vie.', 'EA Games', 'EA Games'),
('Zelda', 49.99, '2023-11-10', 10, 'Aventure dans un monde fantastique.', 'Nintendo', 'Nintendo'),
('Call of Duty', 49.99, '2024-03-05', 18, 'Jeu de tir à la première personne.', 'Activision', 'Treyarch'),
('Final Fantasy', 69.99, '2024-01-25', 12, 'RPG avec une histoire épique.', 'Square Enix', 'Square Enix'),
('Grand Theft Auto', 59.99, '2023-07-30', 18, 'Jeu de monde ouvert avec des activités criminelles.', 'Rockstar Games', 'Rockstar Games'),
('Skyrim', 49.99, '2023-06-12', 15, 'RPG dans un monde ouvert fantastique.', 'Bethesda', 'Bethesda'),
('Resident Evil', 39.99, '2023-10-25', 16, 'Jeu de survie et d''horreur.', 'Capcom', 'Capcom'),
('The Witcher 3', 59.99, '2023-09-20', 18, 'RPG avec un monde ouvert et une histoire riche.', 'CD Projekt', 'CD Projekt'),
('Tekken', 29.99, '2024-02-12', 12, 'Jeu de combat avec des personnages variés.', 'Bandai Namco', 'Bandai Namco'),
('Tekken3', 29.99, '02-12-2024', 12, 'Jeu de combat avec des personnages encore plus variés.', 'Bandai Namco', 'Bandai Namco');

-- Insertion dans la table classer
INSERT INTO classer (id_jeu, id_genre) VALUES 
(1, 1), (2, 2), (3, 3), (4, 6), (5, 4),
(6, 1), (7, 3), (8, 7), (9, 5), (10, 14);

-- Insertion dans la table succes
INSERT INTO succes (code, intitule, condition, id_jeu) VALUES 
('S001', 'Tueur d''élite', 'Terminer tous les objectifs', 1),
('S002', 'Maître des Sims', 'Créer une famille complète', 2),
('S003', 'Héros de Hyrule', 'Finir le jeu sans utiliser d''aide', 3),
('S004', 'Vétéran', 'Atteindre le niveau 50', 4),
('S005', 'Légende Vivante', 'Terminer tous les quêtes secondaires', 5);

-- Insertion dans la table partage
INSERT INTO partage (pseudo1, pseudo2, id_jeu) VALUES 
('Player1', 'Player2', 1), 
('Player3', 'Player4', 2), 
('Player5', 'Player6', 3), 
('Player7', 'Player8', 4), 
('Player9', 'Player10', 5);

-- Insertion dans la table debloquer
INSERT INTO debloquer (pseudo, id_jeu, code, date_obtention) VALUES 
('Player1', 1, 'S001', '2024-01-10'),
('Player2', 2, 'S002', '2024-02-10'),
('Player3', 3, 'S003', '2024-03-10'),
('Player4', 4, 'S004', '2024-04-10'),
('Player5', 5, 'S005', '2024-05-10');

-- Insertion dans la table achat
INSERT INTO achat (pseudo, id_jeu, note, commentaire) VALUES 
('Player1', 1, 4.5, 'Excellent jeu, très immersif!'),
('Player2', 2, 3.5, 'Bon jeu mais manque de contenu.'),
('Player3', 3, 5.0, 'Histoire incroyable et gameplay unique!'),
('Player4', 4, 4.0, 'Assez bon, mais certains bugs.'),
('Player5', 5, 4.5, 'Une expérience de jeu exceptionnelle.'),
('Player6', 6, 2.5, 'Pas ce à quoi je m''attendais.'),
('Player7', 7, 5.0, 'Jeu de survie parfait!'),
('Player8', 8, 3.0, 'Bon mais un peu trop difficile.'),
('Player9', 9, 4.0, 'Vraiment amusant, surtout en multijoueur.'),
('Player10', 10, 4.5, 'Très addictif et bien conçu.');
