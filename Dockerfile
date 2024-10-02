FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    software-properties-common \
    build-essential \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    unzip \
    vim \
    apache2 \
    mysql-server \
    mysql-client

RUN apt-get install -y apache2

RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get --no-install-recommends --no-install-suggests --yes --quiet install \
    php-pear \
    php8.2 \
    php8.2-common \
    php8.2-mbstring \
    php8.2-dev \
    php8.2-xml \
    php8.2-cli \
    php8.2-mysql \
    php8.2-sqlite3 \
    php8.2-mbstring \
    php8.2-curl \
    php8.2-gd \
    php8.2-imagick \
    php8.2-xdebug \
    php8.2-xml \
    php8.2-zip \
    php8.2-odbc \
    php8.2-opcache \
    php8.2-redis \
    autoconf \
    zlib1g-dev \
    libapache2-mod-php8.2

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install 14

RUN mkdir -p /tmp/composer && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2enmod rewrite ssl headers
COPY apache_default /etc/apache2/sites-available/000-default.conf
RUN service apache2 restart

COPY my.cnf /etc/mysql/my.cnf

RUN service mysql start && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

WORKDIR /var/www/html

EXPOSE 80 3306

CMD ["sh", "-c", "service apache2 start && service mysql start && tail -f /dev/null"]
