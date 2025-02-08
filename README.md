# Projet Docker

Créer une application avec une API Symfony avec 1 endpoint qui récupère des data sur une
BDD Postgres et les afficher sur le front. 10 lignes de todo (id, titre, done)
Pour les images custom, toujours partir d'une base alpine

### Groupe de 2 maximum

### Notation :

    - Projet fonctionnel (4 points)
    - Symfony custom (3 points)
    - Adminer custom (3 points)
    - Postgres custom (variables d'environnement fonctionelles) (4 points)
    - Composer custom (3 points)
    - Le Symfony et la BDD sur des docker-compose différents (3 points)

### Rendu final :

Fichier texte sur eemi.tech avec URL d'un GitHub qui contient tout le projet
Mon username GitHub: quentinhermiteau

## Groupe

Baptiste Ballesteros
Antony Lignac

## Commandes

### Lancer les conteneurs :
docker compose -f docker-compose.database.yml up -d
docker compose -f docker-compose.app.yml up -d

### Arrêter les conteneurs :
docker compose -f docker-compose.app.yml down
docker compose -f docker-compose.database.yml down

### Supprimer les images :
docker rmi $(docker images -q)

### Supprimer les conteneurs et les volumes :
docker compose -f docker-compose.app.yml down -v
docker compose -f docker-compose.database.yml down -v

### Supprimer les réseaux :
docker network rm $(docker network ls -q)
