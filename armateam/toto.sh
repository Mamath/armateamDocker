#!/bin/sh
#
# attach with shell : docker exec -it fg bash
#
# sudo docker run -it -v `pwd`/src/:/var/www/ -v `pwd`/php/:/php -p 8080:80 -p 3307:3306 jobsfr

sudo docker run -it -v `pwd`/src/:/home/src/ --rm --name=armateam  -p 8080:80 -p 3310:3306 --dns 8.8.8.8 armateam

