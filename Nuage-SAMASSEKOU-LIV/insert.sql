INSERT INTO entreprise (nom, pays) VALUES 

('Ubisoft', 'France'), 

('EA Games', 'USA'), 

('Nintendo', 'Japan'), 

('Rockstar Games', 'USA');



-- Genre

INSERT INTO genre (nom_genre) VALUES 

('Action'), 

('Adventure'), 

('RPG'), 

('Simulation'), 

('Sports');



-- Porte_monnaie

INSERT INTO porte_monnaie (solde) VALUES 

(500), 

(1200), 

(700), 

(300);



-- Joueur

INSERT INTO joueur (pseudo, mdp, nom, mail, date_naissance, id_monnaie) VALUES 

('PlayerOne', 'password1', 'Alice', 'alice@mail.com', '1995-06-15', 1),

('PlayerTwo', 'password2', 'Bob', 'bob@mail.com', '1990-08-20', 2),

('PlayerThree', 'password3', 'Charlie', 'charlie@mail.com', '2000-03-10', 3),

('PlayerFour', 'password4', 'Dana', 'dana@mail.com', '1985-01-25', 4);



-- Jeu

INSERT INTO jeu (titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev) VALUES 

('Assassin''s Creed', 60.00, '2020-11-10', 18, 'An open-world action game.', 'Ubisoft', 'Ubisoft'),

('FIFA 23', 70.00, '2023-09-27', 3, 'The latest in football simulation.', 'EA Games', 'EA Games'),

('Zelda: Breath of the Wild', 50.00, '2017-03-03', 12, 'An open-world adventure.', 'Nintendo', 'Nintendo'),

('GTA V', 40.00, '2013-09-17', 18, 'A crime and action masterpiece.', 'Rockstar Games', 'Rockstar Games');



-- Succes

INSERT INTO succes (code, intitule, condition, id_jeu) VALUES 

('S001', 'First Kill', 'Eliminate your first enemy.', 1),

('S002', 'Champion', 'Win the league.', 2),

('S003', 'Explorer', 'Discover all locations.', 3),

('S004', 'Millionaire', 'Accumulate 1 million dollars.', 4);



-- Classer

INSERT INTO classer (id_jeu, id_genre) VALUES 

(1, 1), 

(1, 2), 

(2, 5), 

(3, 2), 

(3, 3), 

(4, 1);



-- Reapprovisionner

INSERT INTO reapprovisionner (pseudo, id_monnaie, date_transaction, montant) VALUES 

('PlayerOne', 1, '2024-01-01', 100), 

('PlayerTwo', 2, '2024-01-10', 200), 

('PlayerThree', 3, '2024-01-15', 50), 

('PlayerFour', 4, '2024-01-20', 75);



-- Achat

INSERT INTO achat (pseudo, id_jeu, note, commentaire, date_achat) VALUES 

('PlayerOne', 1, 4.5, 'Amazing gameplay!', '2024-02-01'),

('PlayerTwo', 2, 4.0, 'Great football experience.', '2024-02-10'),

('PlayerThree', 3, 5.0, 'A masterpiece.', '2024-02-15'),

('PlayerFour', 4, 3.5, 'Good, but dated.', '2024-02-20');



-- Partage

INSERT INTO partage (pseudo1, pseudo2, id_jeu, date_partage) VALUES 

('PlayerOne', 'PlayerTwo', 1, '2024-03-01'), 

('PlayerTwo', 'PlayerThree', 2, '2024-03-05'), 

('PlayerThree', 'PlayerFour', 3, '2024-03-10'), 

('PlayerFour', 'PlayerOne', 4, '2024-03-15');



-- Debloquer

INSERT INTO debloquer (pseudo, id_jeu, code, date_obtention) VALUES 

('PlayerOne', 1, 'S001', '2024-04-01'), 

('PlayerTwo', 2, 'S002', '2024-04-05'), 

('PlayerThree', 3, 'S003', '2024-04-10'), 

('PlayerFour', 4, 'S004', '2024-04-15');
