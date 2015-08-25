FROM php:5-apache

MAINTAINER David Forster <david@davidforster.com>

# Install libxslt, zlib and Git
RUN apt-get update && apt-get install -y \
    git \
    libxslt1-dev \
    zlib1g-dev

# enable mysqli, xsl and zlib PHP modules
RUN docker-php-ext-install \
    mysqli \
    xsl \
    zip

# enable mod_rewrite
RUN a2enmod rewrite

# install the php.ini file
COPY ["php.ini", "/usr/local/etc/php/"]

WORKDIR /var/www/html

# Clone Symphony, it's submodules and the sample workspace
RUN git clone git://github.com/symphonycms/symphony-2.git /var/www/html
RUN git checkout --track origin/bundle
RUN git submodule update --init --recursive
RUN git clone git://github.com/symphonycms/workspace.git /var/www/html/workspace

# Set permissions on the files
RUN chown -R www-data:www-data /var/www/html/*
