FROM php:8.0.2-fpm


# Install necessary packages
RUN apt-get -yqq update \
    && apt-get -yqq install --no-install-recommends nginx supervisor unzip zip


# Install composer
COPY docker/php/composer-installer.sh /usr/local/bin/composer-installer

RUN chmod +x /usr/local/bin/composer-installer \
    && composer-installer \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer --version


# Install nodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash \
    && apt-get -yqq install --no-install-recommends nodejs \
    && npm install -g yarn


# Config supervisor
COPY docker/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY docker/supervisor/conf.d/*.conf /etc/supervisor/conf.d-available/


# Config php
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install redis &&  docker-php-ext-enable redis

COPY ./docker/php/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY ./docker/php/conf.d/*.ini /usr/local/etc/php/conf.d/


# Config nginx
COPY ./docker/nginx/h5bp /etc/nginx/h5bp
COPY ./docker/nginx/default /etc/nginx/sites-available/default


# Build project
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN composer install --no-interaction --no-plugins --no-scripts --prefer-dist
RUN yarn install && yarn run production


# Bootstrap
COPY ./docker/bootstrap.sh /usr/local/bin/bootstrap
RUN chmod +x /usr/local/bin/bootstrap

CMD ["/usr/local/bin/bootstrap"]
