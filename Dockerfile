FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    nginx \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql json

WORKDIR /glpi-server

RUN curl -SL "https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz" -o glpi.tgz \
    && tar -xzf glpi.tgz \
    && rm glpi.tgz

RUN chown -R www-data:www-data /glpi-server/glpi

COPY nginx.conf /etc/nginx/sites-available/default

CMD service nginx start && php-fpm
