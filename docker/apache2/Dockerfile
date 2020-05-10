FROM php:7-apache-buster

ENV PROJECT_ROOT /www

RUN set -eux; \
    mkdir ${PROJECT_ROOT} \
    && apt-get update \
    && apt-get install -qq \
        libpq-dev \
        libicu-dev \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        default-mysql-client \
        unzip \
        zlib1g-dev \
    \
    && docker-php-ext-configure \
        gd --with-jpeg \
    \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        exif \
        gd \
        zip \
    \
    \
    && cd /usr/bin \
    && curl -s http://getcomposer.org/installer | php \
    && ln -s /usr/bin/composer.phar /usr/bin/composer \
    \
    && composer global require hirak/prestissimo \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -eux; \
    cd /etc/apache2/mods-enabled \
    && ln -s ../mods-available/rewrite.load

COPY sites /etc/apache2/sites-enabled/

WORKDIR ${PROJECT_ROOT}

ENTRYPOINT \
    usermod -u 1000 www-data \
    && chown -R www-data:www-data ${PROJECT_ROOT} \
    && apache2-foreground
