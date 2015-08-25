FROM php:5-apache

MAINTAINER David Forster <david@davidforster.com>

ENV version 2.6.3

# Install libxslt, zlib and Git
RUN apt-get update && apt-get install -y libxslt1-dev zlib1g-dev git

# enable mysqli, xsl and zlib PHP modules
RUN docker-php-ext-install mysqli xsl zip

# enable mod_rewrite
RUN a2enmod rewrite

# install the php.ini file
ADD ["php.ini", "/usr/local/etc/php/"]

WORKDIR /var/www/html/

#curl -L https://github.com/symphonycms/symphony-2/archive/${version}.tar.gz | tar -zx -C /usr/src

# Clone and install Symphony
RUN git clone git://github.com/symphonycms/symphony-2.git .
RUN git checkout --track origin/bundle
RUN git submodule update --init --recursive
RUN git clone git://github.com/symphonycms/workspace.git

# Set permissions on the files
RUN chown -R www-data:www-data *
