-- Entreprises
INSERT INTO entreprise (nom, pays) VALUES
('Capcom', 'Japon'),
('Square Enix', 'Japon'),
('Bethesda', 'USA'),
('Bungie', 'USA'),
('CD Projekt', 'Pologne'),
('Naughty Dog', 'USA'),
('2K Games', 'USA'),
('Riot Games', 'USA'),
('Sega', 'Japon'),
('Gearbox Software', 'USA'),
('Ubisoft Montreal', 'Canada');

-- Genres de jeux
INSERT INTO genre (nom_genre) VALUES
('Simulation'),
('Stratégie'),
('MMORPG'),
('Survival'),
('VR'),
('Sandbox'),
('Musique'),
('Puzzle'),
('Horreur'),
('Indépendant');

-- Porte-monnaie
INSERT INTO porte_monnaie (solde) VALUES
(1500),
(2000),
(1800),
(2500),
(2300),
(1700),
(2200),
(3000),
(3200),
(2600);

-- Joueurs
INSERT INTO joueur (pseudo, mdp, nom, mail, date_naissance, id_monnaie) VALUES
('Oliver', 'oliver123', 'Oliver Grey', 'oliver@mail.com', '1992-11-01', 1),
('Sophia', 'sophia123', 'Sophia Black', 'sophia@mail.com', '1990-10-12', 2),
('Liam', 'liam123', 'Liam Turner', 'liam@mail.com', '1994-06-20', 3),
('Mia', 'mia123', 'Mia Lee', 'mia@mail.com', '1988-08-09', 4),
('Lucas', 'lucas123', 'Lucas Hall', 'lucas@mail.com', '1996-12-15', 5),
('Amelia', 'amelia123', 'Amelia Scott', 'amelia@mail.com', '1995-04-02', 6),
('Noah', 'noah123', 'Noah White', 'noah@mail.com', '1993-03-23', 7),
('Ava', 'ava123', 'Ava Martin', 'ava@mail.com', '1991-07-15', 8),
('James', 'james123', 'James Harris', 'james@mail.com', '1987-02-14', 9),
('Isabella', 'isabella123', 'Isabella Carter', 'isabella@mail.com', '1999-01-25', 10);

-- Jeux
INSERT INTO jeu (titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev) VALUES
('Resident Evil 4', 60.00, '2023-03-24', 18, 'Survival horror', 'Capcom', 'Capcom'),
('Final Fantasy VII Remake', 70.00, '2020-04-10', 16, 'Jeu de rôle', 'Square Enix', 'Square Enix'),
('Fallout 76', 40.00, '2018-11-14', 18, 'MMORPG', 'Bethesda', 'Bethesda'),
('Destiny 2', 40.00, '2017-09-06', 12, 'Jeu de tir en ligne', 'Bungie', 'Bungie'),
('Cyberpunk 2077', 55.00, '2020-12-10', 18, 'Jeu de rôle', 'CD Projekt', 'CD Projekt'),
('The Last of Us', 60.00, '2013-06-14', 18, 'Action aventure', 'Naughty Dog', 'Naughty Dog'),
('Borderlands 3', 50.00, '2019-09-13', 18, 'Jeu de tir', '2K Games', 'Gearbox Software'),
('League of Legends', 0.00, '2009-10-27', 12, 'MOBA', 'Riot Games', 'Riot Games'),
('Sonic the Hedgehog', 40.00, '2020-12-10', 3, 'Plateforme', 'Sega', 'Sega'),
('Assassin''s Creed Valhalla', 70.00, '2020-11-10', 18, 'Action aventure', 'Ubisoft Montreal', 'Ubisoft Montreal');

-- Classer les jeux dans des genres
INSERT INTO classer (id_jeu, id_genre) VALUES
(1, 9),  -- Resident Evil 4 est un jeu d'Horreur psychologique
(2, 2),  -- Final Fantasy VII Remake est un RPG
(3, 3),  -- Fallout 76 est un MMORPG
(4, 6),  -- Destiny 2 est un jeu Sandbox
(5, 2),  -- Cyberpunk 2077 est un RPG
(6, 1),  -- The Last of Us est un jeu de Simulation
(7, 5),  -- Borderlands 3 est un jeu Survival
(8, 7),  -- League of Legends est un jeu de Musique
(9, 4),  -- Sonic the Hedgehog est un jeu de Puzzle
(10, 1);  -- Assassin's Creed Valhalla est un jeu de Simulation

-- Succès pour les jeux
INSERT INTO succes (code, intitule, condition, id_jeu) VALUES
('S011', 'Survivant', 'Survivre 7 jours dans Resident Evil 4', 1),
('S012', 'Vainqueur de la Guerre', 'Terminer tous les chapitres de Final Fantasy VII Remake', 2),
('S013', 'République Fallout', 'Construire un abri complet dans Fallout 76', 3),
('S014', 'Maître des Armes', 'Tuer 500 ennemis dans Destiny 2', 4),
('S015', 'Cyber Hacker', 'Compléter toutes les missions secondaires de Cyberpunk 2077', 5),
('S016', 'Survivant Ultime', 'Terminer le jeu sur la difficulté la plus élevée dans The Last of Us', 6),
('S017', 'Voleur', 'Voler 100 véhicules dans Borderlands 3', 7),
('S018', 'Légende', 'Obtenir tous les champions dans League of Legends', 8),
('S019', 'Turbo', 'Compléter le jeu à 100% dans Sonic the Hedgehog', 9),
('S020', 'Viking', 'Construire un village complet dans Assassin''s Creed Valhalla', 10);

-- Reapprovisionner (argent ajouté au porte-monnaie)
INSERT INTO reapprovisionner (pseudo, id_monnaie, date_transaction, montant) VALUES
('Oliver', 1, '2024-11-01', 300),
('Sophia', 2, '2024-11-05', 400),
('Liam', 3, '2024-11-10', 500),
('Mia', 4, '2024-11-12', 600),
('Lucas', 5, '2024-11-15', 700),
('Amelia', 6, '2024-11-17', 800),
('Noah', 7, '2024-11-20', 150),
('Ava', 8, '2024-11-22', 900),
('James', 9, '2024-11-25', 1100),
('Isabella', 10, '2024-11-26', 1300);

-- Achats de jeux
INSERT INTO achat (pseudo, id_jeu, note, commentaire, date_achat) VALUES
('Oliver', 1, 4.5, 'Superbes graphismes et ambiance. Bien stressant.', '2024-11-02'),
('Sophia', 2, 5.0, 'Une expérience incroyable, la meilleure des rééditions.', '2024-11-06'),
('Liam', 3, 3.8, 'Je suis encore un peu perdu dans ce monde ouvert.', '2024-11-12'),
('Mia', 4, 4.0, 'Le gameplay est top mais parfois répétitif.', '2024-11-14'),
('Lucas', 5, 4.5, 'Cyberpunk 2077 reste l''un des meilleurs jeux d''action.', '2024-11-17'),
('Amelia', 6, 4.2, 'Histoire excellente, mais la fin était décevante.', '2024-11-18'),
('Noah', 7, 4.8, 'Trop fun, un véritable jeu de tir à la Borderlands!', '2024-11-19'),
('Ava', 8, 5.0, 'Le meilleur jeu multijoueur que j''ai joué.', '2024-11-21'),
('James', 9, 3.5, 'Je l''ai trouvé un peu facile mais très mignon.', '2024-11-23'),
('Isabella', 10, 4.9, 'Un jeu vraiment bien conçu et riche en contenu.', '2024-11-25');

-- Partages de jeux entre joueurs
INSERT INTO partage (pseudo1, pseudo2, id_jeu, date_partage) VALUES
('Oliver', 'Sophia', 1, '2024-11-03'),
('Liam', 'Mia', 3, '2024-11-07'),
('Lucas', 'Amelia', 5, '2024-11-12'),
('Noah', 'Ava', 7, '2024-11-16'),
('James', 'Isabella', 9, '2024-11-22');

-- Déblocages supplémentaires de succès
INSERT INTO debloquer (pseudo, id_jeu, code, date_obtention) VALUES
('Oliver', 1, 'S011', '2024-11-04'),
('Sophia', 2, 'S012', '2024-11-07'),
('Liam', 3, 'S013', '2024-11-10'),
('Mia', 4, 'S014', '2024-11-13'),
('Lucas', 5, 'S015', '2024-11-16'),
('Amelia', 6, 'S016', '2024-11-18'),
('Noah', 7, 'S017', '2024-11-20'),
('Ava', 8, 'S018', '2024-11-22'),
('James', 9, 'S019', '2024-11-24'),
('Isabella', 10, 'S020', '2024-11-27');
