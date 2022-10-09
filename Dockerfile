# 初回laravel install用
FROM php:8.1-fpm-bullseye
WORKDIR /application
RUN apt-get update && apt-get install -y \
            git \
            zip \
            unzip \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer