import db
from flask import Flask, render_template, request, redirect, url_for, session
from passlib.context import CryptContext
import random

app = Flask(__name__)

## Page de connexion
@app.route("/connexion/connexion")
def connexion():
    error_condition = False
    return render_template("/connexion/connexion.html", error = error_condition)

## Lorsqu'on appuie sur le bouton "Se connecter"
app.secret_key = b'988d6b3b992fe9df993a4cb5190fd54a785cf5549eada60c7600e7aa0b03de89'
@app.route("/connexion/login", methods = ['POST'])
def login():
    ## On récupère le pseudo et mdp, si on a rien renseigné, on renvoit erreur
    pseudo = request.form.get("pseudo")
    mdp = request.form.get("password")
    if (not pseudo) or (not mdp):
        return render_template("/connexion/connexion.html", error = True, error_msg = "Veuillez rentrer un pseudo ET un mot de passe !") ## Champs vides
    ## On se connecte à la BDD
    with db.connect() as conn:
        cur = conn.cursor()
        ## On cherche dans la BDD si le pseudo qu'on a rentré est dans la BDD
        cur.execute("SELECT pseudo, mdp FROM joueur WHERE pseudo = %s;", (pseudo,))
        for res in cur: ## Si ce n'est pas le cas, on saute la boucle for et on return Error
            # On vérifie si le mdp correspond aux mdp hashés de l'utilisateur
            password_ctx = CryptContext(schemes=['bcrypt'])
            if password_ctx.verify(mdp, res.mdp): # Alors l'utilisateur s'est connecté avec succès
                session['user_nickname'] = pseudo # On enregistre la session, pour éviter qu'il se reconnecte à chaque fois
                cur.execute('SELECT solde FROM joueur WHERE pseudo = %s', (session['user_nickname'],))
                for res in cur:
                    session['solde'] = res.solde
                # On récupère le solde du joueur, qu'on va afficher tout le long du site

                return redirect(url_for("accueil"))
        return render_template ("/connexion/connexion.html", error = True, error_msg = "Nom d'utilisateur ou mot de passe incorrect !") ## Nom d'utilisateur incorrect


@app.route("/connexion/cree_compte", methods=['POST'])
def cree_compte():
    error_condition = False
    return render_template("/connexion/cree_compte.html", error = error_condition)

## On suppose que l'adresse mail est bien tapé, et qu'on peut avoir comme nom d'utilisateur '       '
@app.route("/connexion/new_compte", methods=['POST'])
def new_compte():
    ## On récupère toutes les informations sous forme de liste
    value_list = request.form.getlist("value") # value_list = [Pseudo, MDP, prénom et nom, mail, date de naissance]
    if any(elem == '' for elem in value_list): ## Si un élément de la liste est égale à '', alors on n'a pas remplit une case
         return render_template("/connexion/cree_compte.html", error = True, error_msg = "Veuillez remplir toutes les informations !")
    with db.connect() as conn:
        cur = conn.cursor()
        ## On vérifie que ce pseudo n'a pas déjà été pris
        cur.execute("SELECT pseudo FROM joueur WHERE pseudo = %s;", (value_list[0],))
        for res in cur: ## Si on rentre dans cette boucle, alors on a trouvé un pseudo
            return render_template("/connexion/cree_compte.html", error = True, error_msg = "Ce pseudo a déjà été utilisé !")
        ## On hash son MDP, puis ensuite on ajoute les données dans la BDD 
        password_ctx = CryptContext(schemes=['bcrypt']) 
        hash_pw = password_ctx.hash(value_list[1])
        cur.execute("INSERT INTO joueur VALUES (%s, %s, %s, %s, %s)", (value_list[0], hash_pw, value_list[2], value_list[3], value_list[4],))
    return render_template("/connexion/connexion.html", create_compte = True, msg = "Le compte a été crée avec succès !")

@app.route("/connexion/back_to_connexion", methods=['POST'])
def back_to_connexion():
    error_condition = False
    return render_template("/connexion/connexion.html", error = error_condition)

@app.route("/accueil")
def accueil():
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))       
    return render_template("/accueil.html", user = session['user_nickname'], solde = session['solde'])

############################################################################################################
## Début des requêtes pour la boutique
@app.route("/boutique")
def boutique():
    ## La liste pour filtrer les jeux, on utilise un dictionnaire en raison de la méthode de GETS 
    lst_type = {
        'Date':"Date de parution",
        'Nombre':"Nombre de ventes",
        'Note':"Note moyenne"
    }
    ## On vérifie qu'une session est active
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    ## On sélectionne toutes les informations en lien avec les JEUX pour qu'on puisse les afficher sur le site 
    with db.connect() as conn:
        cur = conn.cursor()
        ## On récupère le titre, prix, date de sortie, url de l'img, la moyenne de ses notes
        cur.execute('SELECT titre, prix, date_sortie, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, url_img;')
        lst_jeu = cur.fetchall()
    return render_template("/boutique.html", user = session['user_nickname'], solde = session['solde'], lst_jeu = lst_jeu, lst_type = lst_type.values(), default = "Trier par",  filtre = False)

@app.route("/add_filtre", methods = ['GET'])
def add_filtre():
    ## La méthode GETS renvoie seulement le 1er mot, si on selectionne "Date de parution", GETS va renvoyer "Date" seulement, d'où la raison d'un dico
    lst_type = {
        'Date':"Date de parution",
        'Nombre':"Nombre de ventes",
        'Note':"Note moyenne"
    }
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    ## On récupère la méthode de trie
    type_trie = request.args.get("type", None)
    with db.connect() as conn:
        cur = conn.cursor()
        ## En fonction de son résultat, on fait la requête approprié pour trier les jeux
        if type_trie == "Date":
            cur.execute('SELECT titre, prix, date_sortie, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, url_img ORDER BY date_sortie DESC;')
        if type_trie == "Nombre":
            cur.execute('SELECT titre, prix, date_sortie, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, url_img ORDER BY count(jeu.id_jeu) DESC;')
        if type_trie == "Note":
            cur.execute('SELECT titre, prix, date_sortie, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, url_img ORDER BY avg(note) DESC;')
       ## On récupère la liste des filtres
        type_default = lst_type[type_trie]
        del lst_type[type_trie] ## On supprime le filtre qu'on a appliqué pour éviter qu'on le selectionne
        lst_jeu = cur.fetchall()
    return render_template("/boutique.html", user = session['user_nickname'], lst_jeu = lst_jeu, lst_type = lst_type.values(), default = type_default, filtre = True)

@app.route("/supp_filtre")
def supp_filtre():
    return redirect(url_for('boutique'))
## FIN des requêtes pour la boutique

############################################################################################################

## Début des requêtes pour la recherche
@app.route("/recherche")
def recherche():
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    with db.connect() as conn:
        cur = conn.cursor()
        cur.execute('SELECT nom_genre FROM genre;')
        lst_gen = cur.fetchall()
        cur.execute('SELECT nom FROM entreprise;')
        lst_entreprise = cur.fetchall()
    return render_template("/recherche.html", user = session['user_nickname'], solde = session['solde'], lst_jeu = [], lst_genre = lst_gen, lst_editeur = lst_entreprise, lst_developpeur = lst_entreprise, default = ['', False, False, False])

## Pour trier les jeux en fonctions de la barre de recherche ET de ses filtres 
@app.route("/search_game", methods=['GET'])
def search_game():
    '''
    Fonction qui va permettre de faire le filtre dans la page RECHERCHE, la méthode de filtre est la suivante :
        - On récupère la lst des jeux (L1) filtré à partir de la barre de recherche.
        - A partir de cette liste L1, on va filtrer en fonction du genre cette fois ci, on obtiendra une nouvelle lst (L2)
        - A partir de cette liste L2, on va re-filtrer en fonction des Editeurs, on obtienra une nouvelle lst (L3)
        - Pareil pour les Developpeurs.
    On obtient donc une liste finale filtré en fonction des paramètres indiqués.
    Après avoir filtré, on récupère la liste des Genres, Editeurs, Dev en retirant les options sélectionnées 
    '''
    lst_gen = []
    lst_edi = []
    lst_dev = []
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    ## On récupère avec la méthode GETS, 
    titre_recherche = request.args.get("titre_recherche", None) ## GETS renvoie '' si on a pas choisit d'option
    genre = request.args.get("recherche_genre", None) ## GETS renvoie '' si on a pas choisit d'option
    editeur = request.args.get("recherche_editeur", None) ## GETS renvoie '' si on a pas choisit d'option
    dev = request.args.get("recherche_developpeur", None) ## GETS renvoie '' si on a pas choisit d'option
    with db.connect() as conn:
        cur = conn.cursor()
        ## On filtre d'abord en fonction de la barre de recherche grâce à LIKE
        cur.execute('SELECT titre FROM jeu WHERE LOWER(titre) LIKE LOWER(%s);', ("%" + titre_recherche + "%",)) ## On utilise LOWER pour négliger les majuscules
        lst_jeu = cur.fetchall() ## On récupère lst_jeu (= L1)
        ## Si genre ne renvoie pas '', alors on veut filtrer en fonction
        if (genre): 
            lst_jeu_genre = []
            ## On va filtrer mais en fonction de la liste L1 cette fois-ci
            for elem in lst_jeu:
                cur = conn.cursor()
                cur.execute('SELECT titre FROM jeu NATURAL JOIN classer NATURAL JOIN genre WHERE titre = %s AND nom_genre = %s;',(elem.titre, genre,))
                genre_result = cur.fetchone()
                ## Si on trouve un résultat, alors se titre valide la Recherche et le Genre
                if genre_result:
                    lst_jeu_genre.append(genre_result)
            ## On récupère lst_jeu (= L2)
            lst_jeu = lst_jeu_genre
        ## Pareil pour editeur
        if (editeur): 
            lst_jeu_editeur = []
            for elem in lst_jeu:
                cur = conn.cursor()
                cur.execute('SELECT titre FROM jeu WHERE titre = %s AND nom_edite = %s;', (elem.titre, editeur,))
                editeur_result = cur.fetchone()
                if editeur_result:
                    lst_jeu_editeur.append(editeur_result)
            ## On récupère lst_jeu (= L3)
            lst_jeu = lst_jeu_editeur
        ## Pareil pour dev
        if (dev):
            lst_jeu_dev = []
            for elem in lst_jeu:
                cur = conn.cursor()
                cur.execute('SELECT titre FROM jeu WHERE titre = %s AND nom_dev = %s;', (elem.titre, dev,))
                dev_result = cur.fetchone()
                if dev_result:
                    lst_jeu_dev.append(dev_result)
            ## On récupère lst_jeu (= L4)
            lst_jeu = lst_jeu_dev
        ## On a la liste avec seulement les TITRES de tout les jeux, maintenant on récupère les informations concernant le jeu
        ## (titre, prix, date_sortie, url_img, moyenne des notes)
        lst_finale = []
        for elem in lst_jeu:
            cur = conn.cursor()
            cur.execute('SELECT titre, prix, date_sortie, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, url_img HAVING jeu.titre = %s;', (elem.titre,))
            res = cur.fetchone()
            if res:
                lst_finale.append(res)
        ## Ainsi, on obtient la liste finale
        lst_jeu = lst_finale
        
        ##### Lorsqu'on obtient le résultat, on souhaite afficher sur le site les filtres qu'on a appliqués
        ##### On récupère la liste des options, sauf qu'on va mettre l'option choisit en tête de liste
        # Genre
        cur.execute('SELECT nom_genre FROM genre WHERE nom_genre = %s;', (genre,)) # On sélectionne l'option choisis
        for res in cur:
            lst_gen.append(res)
        cur.execute('SELECT nom_genre FROM genre EXCEPT SELECT nom_genre FROM genre WHERE nom_genre = %s;', (genre,)) # On sélectionne les autres
        for res in cur:
            lst_gen.append(res) # On obtient la liste des genres, avec en tête le genre choisi
        # Editeur
        cur.execute('SELECT nom FROM entreprise WHERE nom = %s;', (editeur,))
        for res in cur:
            lst_edi.append(res)
        cur.execute('SELECT nom FROM entreprise EXCEPT SELECT nom FROM entreprise WHERE nom = %s ;', (editeur,))
        for res in cur:
            lst_edi.append(res)
        # Dev
        cur.execute('SELECT nom FROM entreprise WHERE nom = %s;', (dev,))
        for res in cur:
            lst_dev.append(res)
        cur.execute('SELECT nom FROM entreprise EXCEPT SELECT nom FROM entreprise WHERE nom = %s ;', (dev,))
        for res in cur:
            lst_dev.append(res)
        ## Si on a trouvé aucun jeu correspondant aux filtres, on affiche à l'utilisateur qu'on a trouvé aucun jeu
        if not lst_jeu:
                return render_template("/recherche.html", user = session['user_nickname'], solde = session['solde'], lst_jeu = lst_jeu, nothing = True, lst_genre = lst_gen, lst_editeur = lst_edi, lst_developpeur = lst_dev, default = [titre_recherche, genre, editeur, dev], filtre=True)
    return render_template("/recherche.html", user = session['user_nickname'], solde = session['solde'], lst_jeu = lst_jeu, lst_genre = lst_gen, lst_editeur = lst_edi, lst_developpeur = lst_dev, default = [titre_recherche, genre, editeur, dev], filtre=True)
    
@app.route("/supp_filtre_recherche")
def supp_filtre_recherche():
    return redirect(url_for('recherche'))

## Fin des requêtes pour la recherche
############################################################################################################
## Début des requêtes pour les jeux

@app.route("/game_click/<string:type>", methods=['GET'])
def game_click(type):
    ## type = type.replace("%2F", "/")
    type = type.replace("%20", " ") ## Le caractère %20 est la touche espace convertit, on remplace donc le caractère %20 par des ' '
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    ## On sélectionne toutes les informations en lien avec le JEU pour qu'on puisse les afficher sur le site 
    with db.connect() as conn:
        cur = conn.cursor()
        ## On récupère le titre, prix, date de sortie, url de l'img, la moyenne de ses notes
        cur.execute('SELECT titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev, url_img, ROUND(avg(note), 1) AS moyenne FROM jeu LEFT JOIN achat ON (jeu.id_jeu = achat.id_jeu) GROUP BY jeu.id_jeu, titre, prix, date_sortie, age_min, synopsis, nom_edite, nom_dev, url_img HAVING titre = %s;', (type,))
        lst_jeu = cur.fetchone()
        cur.execute('SELECT * FROM achat NATURAL JOIN jeu WHERE titre = %s;', (lst_jeu.titre,))
        lst_avis = cur.fetchall()
        cur.execute('SELECT nom_genre FROM jeu NATURAL JOIN classer NATURAL JOIN genre WHERE titre = %s', (lst_jeu.titre,))
        lst_genre = cur.fetchall()
    return render_template("jeu.html", user = session['user_nickname'], solde= session['solde'] ,  lst_jeu = lst_jeu, lst_avis = lst_avis, lst_genre = lst_genre)

@app.route("/game_click/buy_game/<string:type>", methods=['GET'])
def buy_game(type):
    print(type)
    return type

## FIN des requêtes pour les jeux



## Début des requêtes pour le profil
@app.route("/profil")
def profil():
    if 'user_nickname' not in session:
        return redirect(url_for('connexion'))
    with db.connect() as conn:
        cur = conn.cursor()
        cur.execute('SELECT * FROM joueur WHERE pseudo = %s;', (session['user_nickname'],) )
        lst_joueur = cur.fetchone()
        cur.execute('SELECT id_jeu, titre, prix, url_img, date_achat, note FROM joueur NATURAL JOIN achat NATURAL JOIN jeu WHERE pseudo = %s ORDER BY date_achat;', (session['user_nickname'],))
        lst_jeu = cur.fetchall()
        cur.execute('SELECT DISTINCT id_jeu, titre, url_img FROM partage NATURAL JOIN jeu WHERE pseudo2 = %s;', (session['user_nickname'],))
        lst_jeu_partager = cur.fetchall()
        dic_succes =  {}
        dic_succes_partager =  {}
        for ligne in lst_jeu:
            cur.execute('SELECT intitule, condition, date_obtention FROM succes NATURAL LEFT JOIN ( SELECT * FROM debloquer WHERE id_jeu = %s  AND pseudo = %s) AS debloquer_jeu WHERE id_jeu = %s ORDER BY date_obtention ASC;', (ligne.id_jeu, session['user_nickname'], ligne.id_jeu,))
            dic_succes[ligne.id_jeu] = cur.fetchall()
        for ligne in lst_jeu_partager:
            cur.execute('SELECT pseudo1, date_partage FROM partage WHERE id_jeu = %s  AND pseudo2 = %s ORDER BY date_partage;', (ligne.id_jeu, session['user_nickname'],))
            dic_succes_partager[ligne.id_jeu] = cur.fetchall()
        
    return render_template("/profil.html", user = session['user_nickname'] , solde = session['solde'], joueur = lst_joueur,
                           lst_jeu = lst_jeu, dic_succes = dic_succes, lst_jeu_partager = lst_jeu_partager, dic_succes_partager =dic_succes_partager)

@app.route("/disconnect")
def disconnect():
    session.pop('user_nickname', None)
    return redirect(url_for('connexion'))



if __name__ == '__main__':
  app.run()