FROM php:8.4-fpm-alpine

ENV APP_HOME /var/www
ENV USERNAME=www-data

# Install system dependencies
RUN apk update && apk add \
    git \
    unzip \
    icu-dev \
    oniguruma-dev \
    libzip-dev \
    zip \
    nano \
    && docker-php-ext-install intl pdo pdo_mysql zip opcache mbstring

RUN apk add --update linux-headers

RUN deluser www-data
RUN addgroup -g 1000 www-data
RUN adduser -D -u 1000 -g "Main developer" -s /bin/bash -G www-data www-data

RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
COPY --from=composer:latest --chown=${USERNAME}:${USERNAME} /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

###> recipes ###
###< recipes ###

# Set permissions
RUN chown -R ${USERNAME}:${USERNAME} ${APP_HOME}

# Set working folder
WORKDIR ${APP_HOME}

# Set working user
USER ${USERNAME}

# Copy app files
COPY --chown=${USERNAME}:${USERNAME} . ${APP_HOME}

# Enable Console Symfony
RUN chmod +x ${APP_HOME}/bin/console

CMD ["php-fpm"]
