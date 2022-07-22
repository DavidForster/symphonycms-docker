FROM php:7-apache

# Install libxslt, zlib and Git
RUN apt-get update \
    && apt-get install -y \
        git \
        libxslt1-dev \
        libzip-dev \
    && apt-get clean \
    && apt-get autoremove \
    && rm -r /var/lib/apt/lists/*

# enable mysqli, xsl and zlib PHP modules
RUN docker-php-ext-install \
    mysqli \
    xsl \
    zip

# enable mod_rewrite
RUN a2enmod rewrite

# Clone Symphony, it's submodules and the sample workspace
RUN git clone --branch 2.7.10 --depth 1 https://github.com/symphonycms/symphonycms.git /var/www/html \
    # && git submodule update --init --recursive \
    && git clone --depth 1 https://github.com/symphonycms/workspace.git \
    && chown -R www-data:www-data *
