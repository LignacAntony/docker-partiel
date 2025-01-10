FROM alpine:latest

# Installation des dépendances nécessaires
RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-pdo \
    php83-pdo_mysql \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-zlib \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-xmlwriter \
    php83-xmlreader \
    php83-ctype \
    php83-session \
    php83-mbstring \
    php83-tokenizer \
    bash \
    curl \
    composer

# Remplacer le lien symbolique existant
RUN rm -f /usr/bin/php && ln -s /usr/bin/php83 /usr/bin/php

# Installation de Symfony CLI
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash \
    && apk add symfony-cli

# Définition du répertoire de travail
WORKDIR /app

# Copie des fichiers du projet
COPY todo-app/. .

EXPOSE 8000

CMD ["tail", "-f", "/dev/null"]