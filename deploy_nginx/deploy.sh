#!/bin/sh
# @file
# @brief ...
#
# @author tommy vegetables <leafyrabbet@gmail.com>
# @copyright 2020, TenonGarden Productions

INSTALLDIR=/var/www/flaskapp
SOCKETNAME=flasktest.sock

sed 's/SOCKETNAME/'"$SOCKETNAME"'/g' flasktest.ini > /var/www/flasktest/flasktest.ini;

sed 's/SOCKETNAME/'"$SOCKETNAME"'/g' flasktest > /etc/nginx/sites-available/flasktest;

ln -s /etc/nginx/sites-available/flasktest /etc/nginx/sites-enabled/flasktest;
