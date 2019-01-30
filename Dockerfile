FROM php:5.4.45-apache
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-utils \
	make \
	git \
	zip \
	vim \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev \
	libssl-dev \
	libmemcached-dev \
	libz-dev \
	libmysqlclient18 \
	zlib1g-dev \
	libsqlite3-dev \
	libxml2-dev \
	libcurl3-dev \
	libedit-dev \
	libpspell-dev \
	libldap2-dev \
	unixodbc-dev \
	libpq-dev \
	mysql-client


RUN echo "Installing PHP extensions" \
	&& docker-php-ext-install iconv gd pdo_mysql  mbstring zip bcmath calendar dba exif ftp gettext mcrypt  mysql mysqli pcntl shmop soap sockets sysvsem  sysvmsg  sysvshm wddx \
	&& docker-php-ext-enable iconv gd pdo_mysql  mbstring zip bcmath  calendar dba exif ftp gettext mcrypt mysql mysqli pcntl shmop soap sockets sysvsem sysvmsg sysvshm wddx \
	&& apt-get autoremove -y \
	&& apt-get clean all \
	&& rm -rvf /var/lib/apt/lists/* \
	&& rm -rvf /usr/share/doc /usr/share/man /usr/share/locale

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/bin
ENV PATH /root/.composer/vendor/bin:$PATH

# install (old) phpunit
RUN curl https://phar.phpunit.de/phpunit-old.phar -L > phpunit.phar \
	&& chmod +x phpunit.phar \
	&& mv phpunit.phar /usr/local/bin/phpunit \
	&& phpunit --version

COPY ./modellbilder.conf  /etc/apache2/sites-enabled/
RUN a2enmod expires rewrite

VOLUME /var/www/html
CMD ["apache2-foreground"]
