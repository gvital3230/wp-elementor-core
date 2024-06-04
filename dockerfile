FROM wordpress:6.5.3-php8.2-apache

COPY --chown=www-data:www-data . /var/www/html
