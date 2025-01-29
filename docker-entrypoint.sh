#!/bin/bash
set -e

# Démarrer PostgreSQL avec les bonnes permissions
if [ "$1" = 'postgres' ]; then
    chown -R postgres:postgres /var/lib/postgresql/data
    chown -R postgres:postgres /run/postgresql
    
    # Initialiser la base de données si nécessaire
    if [ -z "$(ls -A /var/lib/postgresql/data)" ]; then
        su-exec postgres initdb
    fi
    
    # Démarrer temporairement PostgreSQL pour créer l'utilisateur et la base de données
    su-exec postgres pg_ctl -D /var/lib/postgresql/data start
    
    if [ "$POSTGRES_USER" ]; then
        # Vérifier si l'utilisateur existe déjà
        if ! su-exec postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$POSTGRES_USER'" | grep -q 1; then
            su-exec postgres psql --command "CREATE USER \"$POSTGRES_USER\" WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD';"
        fi
    fi
    
    if [ "$POSTGRES_DB" ]; then
        # Vérifier si la base de données existe déjà
        if ! su-exec postgres psql -lqt | cut -d \| -f 1 | grep -qw "$POSTGRES_DB"; then
            su-exec postgres createdb -O "$POSTGRES_USER" "$POSTGRES_DB"
        fi
        
        # Créer la table todo si elle n'existe pas et insérer des données
        su-exec postgres psql -d "$POSTGRES_DB" <<-EOSQL
            CREATE TABLE IF NOT EXISTS todo (
                id SERIAL PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                description TEXT,
                status VARCHAR(50) DEFAULT 'à faire',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                due_date DATE
            );

            -- Vérifier si la table est vide avant d'insérer les données
            DO \$\$
            BEGIN
                IF NOT EXISTS (SELECT 1 FROM todo) THEN
                    INSERT INTO todo (title, description, status, due_date) VALUES
                    ('Faire les courses', 'Acheter des fruits et légumes', 'à faire', CURRENT_DATE + INTERVAL '2 days'),
                    ('Réviser Docker', 'Préparer l''examen de Docker', 'en cours', CURRENT_DATE + INTERVAL '5 days'),
                    ('Appeler le médecin', 'Prendre rendez-vous pour le check-up annuel', 'à faire', CURRENT_DATE + INTERVAL '1 day'),
                    ('Faire du sport', 'Séance de jogging de 30 minutes', 'terminé', CURRENT_DATE),
                    ('Payer les factures', 'Électricité et internet', 'à faire', CURRENT_DATE + INTERVAL '3 days'),
                    ('Nettoyer l''appartement', 'Faire le ménage complet', 'en cours', CURRENT_DATE + INTERVAL '1 day'),
                    ('Préparer la présentation', 'Présentation du projet final', 'à faire', CURRENT_DATE + INTERVAL '7 days'),
                    ('Maintenance voiture', 'Vidange et contrôle technique', 'à faire', CURRENT_DATE + INTERVAL '10 days'),
                    ('Acheter un cadeau', 'Anniversaire de Marie', 'à faire', CURRENT_DATE + INTERVAL '4 days'),
                    ('Mise à jour CV', 'Ajouter les nouvelles compétences', 'en cours', CURRENT_DATE + INTERVAL '6 days');
                END IF;
            END
            \$\$;
EOSQL
    fi
    
    # Arrêter PostgreSQL
    su-exec postgres pg_ctl -D /var/lib/postgresql/data stop
    
    # Démarrer PostgreSQL avec les bons paramètres
    exec su-exec postgres "$@"
fi

exec "$@" 