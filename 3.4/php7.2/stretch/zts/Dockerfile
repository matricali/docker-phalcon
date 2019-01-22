#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM php:7.2-zts-stretch

MAINTAINER Jorge Matricali <jorgematricali@gmail.com>

ENV PHALCON_VERSION 3.4.2
ENV PHALCON_URL https://codeload.github.com/phalcon/cphalcon/tar.gz/v3.4.2

RUN set -x && \
    apt-get update && \
    # Install dependencies
    apt-get install --no-install-recommends --no-install-suggests -y git unzip libpng-dev && \
    # Build and install PHP extensions
    docker-php-ext-install -j$(nproc) pdo && \
    docker-php-ext-install -j$(nproc) pdo_mysql && \
    docker-php-ext-install -j$(nproc) bcmath && \
    docker-php-ext-install -j$(nproc) gd && \
    yes | pecl install xdebug && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    # Build and install Phalcon extension
    cd /tmp/ && \
    curl -O "${PHALCON_URL}" && \
    tar xvzf "v${PHALCON_VERSION}" && rm "v${PHALCON_VERSION}" && \
    cd "cphalcon-${PHALCON_VERSION}/build" && \
    ./install && \
    docker-php-ext-enable phalcon && \
    # Composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # PHPUnit
    curl -L 'https://phar.phpunit.de/phpunit-7.phar' > /usr/bin/phpunit && \
    chmod a+x /usr/bin/phpunit && \
    # MongoDB
    apt-get install --no-install-recommends --no-install-suggests -y libcurl4-openssl-dev libssl-dev pkg-config && \
    pecl install mongodb && \
    docker-php-ext-enable mongodb && \
    # Eliminar cosas que ya no necesitamos :D
    apt-get remove --purge --auto-remove -y libpng-dev libcurl4-openssl-dev libssl-dev pkg-config && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -fr /var/lib/apt/lists/* && \
    rm -fr /tmp/* /var/tmp/*
