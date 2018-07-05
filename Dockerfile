FROM php:7.0-fpm

MAINTAINER Jorge Matricali <jorgematricali@gmail.com>

RUN apt-get update && \
    apt-get install -y git unzip
RUN apt-get install -y libpng-dev

RUN docker-php-ext-install -j$(nproc) pdo
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) gd

RUN curl -O https://codeload.github.com/phalcon/cphalcon/tar.gz/v3.3.1 && \
    tar xvzf v3.3.1 && rm v3.3.1 && \
    cd cphalcon-3.3.1/build && ./install && \
    rm -rf ~/cphalcon-3.3.1 && rm -rf ~/v3.3.1  && \
    docker-php-ext-enable phalcon

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN curl -L 'https://phar.phpunit.de/phpunit-5.7.phar' > /usr/bin/phpunit57 && \
    chmod a+x /usr/bin/phpunit57

RUN curl -L 'https://phar.phpunit.de/phpunit-7.phar' > /usr/bin/phpunit && \
    chmod a+x /usr/bin/phpunit

RUN apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
