FROM wordpress:6.5.3-php8.2-apache

RUN apt-get update \
  && apt-get install -y vim ssl-cert unzip iputils-ping net-tools

RUN docker-php-ext-install mysqli bcmath
RUN pecl install xdebug-3.3.1
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini
RUN echo "xdebug.output_dir=/var/www/html" >> /usr/local/etc/php/php.ini
RUN echo "xdebug.start_with_request = trigger" >> /usr/local/etc/php/php.ini

# composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh && bash nodesource_setup.sh && apt-get install -y nodejs

RUN apt-get clean

# set ownership to home folder to let run npm install
RUN chown www-data:www-data /var/www

COPY --chown=www-data:www-data . /var/www/html

STOPSIGNAL SIGTERM
