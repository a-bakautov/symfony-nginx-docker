FROM php:8.4-fpm-alpine

ENV APP_HOME /var/www/html
ENV USERNAME=developer

# Install system dependencies
RUN apk update && apk add \
    git \
    unzip \
    icu-dev \
    oniguruma-dev \
    libzip-dev \
    zip \
    nano \
    sudo \
    && docker-php-ext-install intl pdo pdo_mysql zip opcache mbstring

RUN apk add --update linux-headers

RUN addgroup -g 1000 developer
RUN adduser -D -u 1000 -g "Main developer" -s /bin/bash -G developer developer

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

COPY ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log
RUN chmod -R 777 /var/log

# Install Composer
COPY --from=composer:latest --chown=${USERNAME}:${USERNAME} /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

###> recipes ###
###< recipes ###

# Set working user
USER ${USERNAME}

CMD ["php-fpm"]
