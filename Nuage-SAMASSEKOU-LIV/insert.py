import random
import faker
from datetime import datetime, timedelta

# Initialisation des données fictives
fake = faker.Faker()

# Fonction pour générer des données fictives
def generate_data_for_table(table_name, columns, num_rows):
    rows = []
    for _ in range(num_rows):
        if table_name == "entreprise":
            rows.append((fake.company(), fake.country()))
        elif table_name == "genre":
            rows.append((None, fake.word()))
        elif table_name == "porte_monnaie":
            rows.append((None, random.randint(0, 10000)))
        elif table_name == "joueur":
            rows.append(
                (
                    fake.user_name(),
                    fake.password(),
                    fake.last_name(),
                    fake.email(),
                    fake.date_of_birth(minimum_age=18, maximum_age=65).strftime("%Y-%m-%d"),
                    random.randint(1, num_rows // 10),  # Id_monnaie approximatif
                )
            )
        elif table_name == "jeu":
            rows.append(
                (
                    None,
                    fake.text(max_nb_chars=20).strip('.'),
                    round(random.uniform(10, 100), 2),
                    (datetime.now() - timedelta(days=random.randint(0, 3650))).strftime("%Y-%m-%d"),
                    random.randint(3, 18),
                    fake.text(max_nb_chars=50),
                    fake.company(),
                    fake.company(),
                )
            )
        elif table_name == "succes":
            rows.append(
                (
                    fake.lexify(text="????"),
                    fake.text(max_nb_chars=20).strip('.'),
                    fake.text(max_nb_chars=30),
                    random.randint(1, num_rows // 10),  # Id_jeu approximatif
                )
            )
        elif table_name == "classer":
            rows.append((random.randint(1, num_rows // 10), random.randint(1, num_rows // 10)))
    return rows

# Génération des données pour chaque table
tables = {
    "entreprise": ["nom", "pays"],
    "genre": ["id_genre", "nom_genre"],
    "porte_monnaie": ["id_monnaie", "solde"],
    "joueur": ["pseudo", "mdp", "nom", "mail", "date_naissance", "id_monnaie"],
    "jeu": ["id_jeu", "titre", "prix", "date_sortie", "age_min", "synopsis", "nom_edite", "nom_dev"],
    "succes": ["code", "intitule", "condition", "id_jeu"],
    "classer": ["id_jeu", "id_genre"],
}

# Générer des données pour chaque table et sauvegarder dans des fichiers
output_files = {}
num_rows_per_table = 100  # Nombre de lignes pour chaque table

for table_name, columns in tables.items():
    data = generate_data_for_table(table_name, columns, num_rows_per_table)
    output_path = f"data/{table_name}_insert.sql"
    with open(output_path, "w", encoding="utf-8") as file:
        for row in data:
            values = ", ".join(f"'{v}'" if isinstance(v, str) else str(v) for v in row)
            file.write(f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({values});\n")
    output_files[table_name] = output_path

output_files

