
FROM php:7.2-apache

# Enable Apache Rewrite + Expires Module
RUN a2enmod rewrite expires
RUN a2dismod mpm_worker
RUN a2dismod mpm_event

# Install dependencies
RUN apt-get update && apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libyaml-dev \
        libsqlite3-0 \
        sqlite3 \
    && docker-php-ext-install opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
		echo 'upload_max_filesize=128M'; \
		echo 'post_max_size=128M'; \
	} > /usr/local/etc/php/conf.d/php-recommended.ini

# Set user to www-data
RUN chown www-data:www-data /var/www
USER www-data

# Define Grav version
ENV GRAV_VERSION 1.5.9

# Install grav
WORKDIR /var/www
RUN curl -o grav.zip -SL https://getgrav.org/download/core/grav/${GRAV_VERSION} && \
    unzip grav.zip && \
    mv -T /var/www/grav /var/www/html && \
    rm grav.zip

# Return to root user
USER root

WORKDIR /var/www/html

RUN rm -rf ./user
COPY ./user ./user
RUN chmod a+rwx -R ./user

RUN bin/plugin tntsearch index
RUN chmod a+rwx -R ./cache

CMD sed -i "s/80/$PORT/g" /etc/apache2/sites-enabled/000-default.conf /etc/apache2/ports.conf && docker-php-entrypoint apache2-foreground