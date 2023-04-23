FROM php:8.2.4-cli-alpine3.17

RUN apk add --no-cache bash \
    zlib-dev \
    libzip-dev \
    build-base  \
    autoconf \
    automake \
    libtool \
    icu-dev \
    nodejs \
    npm \
    && rm -rf /tmp/* \
    /usr/share/man

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && pecl install openswoole \
    && npm install -g chokidar

RUN apk del autoconf automake libtool

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir /run/nginx && \
    mkdir /var/cert

COPY ./php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./entrypoint.sh /var/entrypoint.sh

WORKDIR /var/www
ENTRYPOINT ["/bin/sh", "/var/entrypoint.sh"]

EXPOSE 8000