FROM ubuntu:16.04
MAINTAINER Aurélien ASSEMAT <aurelien.assemat@gmail.com>

# Packages install
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main " > /etc/apt/sources.list.d/ondrej-php-xenial.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get -y update && apt-get install -y software-properties-common \
    && apt-get install -y php7.0 php7.0-xdebug php7.0-mysql php7.0-intl php7.0-cli php7.0-dev php7.0-tidy php7.0-curl php7.0-gd php7.0-fpm php7.0-zip php7.0-mbstring php7.0-sqlite \
	supervisor nodejs ruby gearman-job-server libgearman-dev libicu-dev libhiredis-dev git \
	apache2 acl ruby-dev fabric

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor /home/src
RUN ln -fs /usr/bin/nodejs /usr/bin/node

# Config Apache
RUN rm /etc/apache2/sites-enabled/* /etc/apache2/sites-available/*
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
