FROM php:7.1-fpm

COPY ./sources.list.stretch /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y iputils-ping vim procps net-tools wget \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && apt-get install -y libmcrypt-dev libmemcached-dev libmagickwand-dev libmagickcore-dev \
    && :\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && :\
    && apt-get install -y libicu-dev \
    && docker-php-ext-install intl

RUN apt-get install -y libxml2-dev \
    && apt-get install -y libxslt-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install wddx \
    && :\
    && apt-get install -y libbz2-dev \
    && docker-php-ext-install bz2

RUN docker-php-ext-install pcntl \
    && docker-php-ext-install sockets \
    && docker-php-ext-install shmop \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm

RUN docker-php-ext-install gettext \
    && docker-php-ext-install zip \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install opcache

RUN docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql

RUN apt-get install -y libldb-dev \
    && apt-get install -y libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap

RUN cd /tmp \
    && wget http://pecl.php.net/get/mcrypt-1.0.1.tgz \
    && wget http://pecl.php.net/get/redis-3.1.6.tgz \
    && wget http://pecl.php.net/get/imagick-3.4.3.tgz \
    && wget http://pecl.php.net/get/memcached-3.0.4.tgz  \
    && wget http://pecl.php.net/get/xdebug-2.6.0.tgz \
    && pecl install mcrypt-1.0.1.tgz \
    && :\
    && pecl install redis-3.1.6.tgz \
    && :\
    && pecl install imagick-3.4.3.tgz \
    && :\
    && pecl install memcached-3.0.4.tgz  \
    && :\
    && pecl install xdebug-2.6.0.tgz \
    && :\
    && :\
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/*.tgz

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
