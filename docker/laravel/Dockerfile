FROM php:8.1-fpm-bullseye

COPY ./docker/laravel/php.ini /usr/local/etc/php/php.ini
COPY ./src /application
# COPY --chown=www-data:www-data ./src /application
WORKDIR /application

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
		git \
		zip \
		unzip \
		&& composer install \
		&& docker-php-ext-install pdo_mysql bcmath

RUN php artisan cache:clear \
		&& php artisan config:clear \
		&& php artisan route:clear \
		&& php artisan view:clear
RUN chown -R www-data:www-data storage