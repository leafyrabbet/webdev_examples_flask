#!/bin/sh
# @file
# @brief ...
#
# @author tommy vegetables <leafyrabbet@gmail.com>
# @copyright 2020, TenonGarden Productions

USERUSER=`id -un`
USERGROUP=`id -gn`
UWSGIAPP=`which uwsgi | sed 's;\/;\\\/;g'`
echo ${USERUSER}
echo ${USERGROUP}
echo ${UWSGIAPP}

sed 's/USERUSER/'"$USERUSER"'/g' flaskapp.service |\
   sed 's/USERGROUP/'"$USERGROUP"'/g' |\
   sed 's/UWSGIAPP/'"$UWSGIAPP"'/g' \
   > flaskapp_built.service

cat flaskapp_built.service

sudo -E mv flaskapp_built.service /etc/systemd/system/flaskapp.service

sudo -E mkdir -p /var/www/flaskapp/
sudo -E cp ../flask_app.ini /var/www/flaskapp/
sudo -E cp ../flask_app.py /var/www/flaskapp/
sudo -E cp ../hello.mustache /var/www/flaskapp/
