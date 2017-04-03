FROM ubuntu:16.04
MAINTAINER Aurélien ASSEMAT <aurelien.assemat@gmail.com>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND=noninteractive
#add Repositories
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 46C2130DFD2497F5 \
    && echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ondrej-ubuntu-php-xenial.list \
    && apt-get update

# Packages install
RUN apt-get install -y php7.1 php7.1-xdebug php7.1-mysql php7.1-pdo-mysql php7.1-intl php7.1-cli php7.1-dev php7.1-tidy php7.1-curl \
    php7.1-gd php7.1-fpm php7.1-zip php7.1-mbstring php7.1-sqlite php7.1-xml \
	nodejs ruby gearman-job-server libgearman-dev libicu-dev libhiredis-dev git \
	supervisor nginx acl ruby-dev fabric vim nodejs npm yarn
RUN phpenmod pdo_mysql

RUN mkdir -p /home/src
RUN ln -fs /usr/bin/nodejs /usr/bin/node

# Config Nginx
ADD config/nginx/nginx.conf /etc/nginx
ADD config/nginx/symfony.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony
RUN rm /etc/nginx/sites-enabled/default

# Config PHP
RUN mkdir -p /var/log/php-fpm \
    && chown www-data: /var/log/php-fpm \
    && mkdir -p /run/php && chown www-data: /run/php

# Composer & symfony
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony \
	&& chmod a+x /usr/local/bin/symfony

RUN ln -fs /home/src/api /home/api
RUN ln -fs /home/src/admin /home/admin

COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN HTTPDUSER=`ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`
#RUN setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX /home/api/var
#RUN setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX /home/api/var

# 1000 c'est l'id user des volumes et cela permet de ne pas avoir de pb droit
RUN usermod -u 1000 www-data
RUN locale-gen en_GB
RUN locale-gen en_GB.ISO-8859-15
RUN locale-gen en_GB.UTF-8
RUN locale-gen fr_FR.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG=en_GB.UTF-8
EXPOSE 80 8484 22 3000
CMD ["/usr/bin/supervisord"]
