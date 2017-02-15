FROM ubuntu:16.04
MAINTAINER Aurélien ASSEMAT <aurelien.assemat@gmail.com>

# Packages install
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main " > /etc/apt/sources.list.d/ondrej-php-xenial.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get -y update && apt-get install -y software-properties-common \
    && apt-get install -y php7.0 php7.0-xdebug php7.0-mysql php7.0-intl php7.0-cli php7.0-dev php7.0-tidy php7.0-curl php7.0-gd php7.0-fpm php7.0-zip php7.0-mbstring php7.0-sqlite \
	nodejs ruby gearman-job-server libgearman-dev libicu-dev libhiredis-dev git \
	supervisor nginx acl ruby-dev fabric

RUN mkdir -p /home/src
RUN ln -fs /usr/bin/nodejs /usr/bin/node

# Config Nginx
ADD config/nginx/nginx.conf /etc/nginx
ADD config/nginx/symfony.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN rm /etc/nginx/sites-enabled/default

# Config PHP
RUN mkdir -p /var/log/php-fpm && chown www-data: /var/log/php-fpm \
    && mkdir -p /run/php && chown www-data: /run/php

# Composer & symfony
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony \
	&& chmod a+x /usr/local/bin/symfony

RUN ln -fs /home/src/tournament /home/

COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 1000 c'est l'id user des volumes et cela permet de ne pas avoir de pb droit
RUN usermod -u 1000 www-data
RUN locale-gen en_GB
RUN locale-gen en_GB.ISO-8859-15
RUN locale-gen en_GB.UTF-8
RUN locale-gen fr_FR.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG=en_GB.UTF-8
EXPOSE 80 3306 8484 22
CMD ["/usr/bin/supervisord"]
