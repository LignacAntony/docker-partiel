# Projet Docker

## Groupe

Baptiste Ballesteros
Antony Lignac

# Commandes

## Lancer les conteneurs
docker compose -f docker-compose.database.yml up -d
docker compose -f docker-compose.app.yml up -d

## Arrêter les conteneurs
docker compose -f docker-compose.app.yml down
docker compose -f docker-compose.database.yml down

## Supprimer les images
docker rmi $(docker images -q)

## Supprimer les conteneurs et les volumes
docker compose -f docker-compose.app.yml down -v
docker compose -f docker-compose.database.yml down -v

## Supprimer les réseaux
docker network rm $(docker network ls -q)
