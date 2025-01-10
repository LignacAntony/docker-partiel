# Projet Docker

Créer une application avec une API Symfony avec 1 endpoint qui récupère des data sur une
BDD Postgres et les afficher sur le front. 10 lignes de todo (id, titre, done)
Pour les images custom, toujours partir d'une base alpine

## Groupe de 2 maximum

## Notation :

    - Projet fonctionnel (4 points)
    - Symfony custom (3 points)
    - Adminer custom (3 points)
    - Postgres custom (variables d'environnement fonctionelles) (4 points)
    - Composer custom (3 points)
    - Le Symfony et la BDD sur des docker-compose différents (3 points)

## Rendu final :

Fichier texte sur eemi.tech avec URL d'un GitHub qui contient tout le projet
Mon username GitHub: quentinhermiteau



CMD IMPORTANTE : 
docker compose up -d --build
docker compose exec app symfony serve