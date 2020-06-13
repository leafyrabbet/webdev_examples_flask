#!/bin/sh

if [[ -n ${ZSH_NAME} ]]; then
   emulate -LR bash;
fi

INSTALL_DIR=/usr/local/opt/flaskapp;

mkdir -p ${INSTALL_DIR};
cp ../flask_app.ini ${INSTALL_DIR}/flask_app.ini;
cp ../flask_app.py ${INSTALL_DIR}/flask_app.py;
cp ../hello.mustache ${INSTALL_DIR}/hello.mustache;

cp com.flasksocket.uwsgi.plist ~/Library/LaunchAgents/com.flasksocket.uwsgi.plist;
launchctl stop com.flasksocket.uwsgi;
launchctl unload ~/Library/LaunchAgents/com.flasksocket.uwsgi.plist;
launchctl load ~/Library/LaunchAgents/com.flasksocket.uwsgi.plist;
launchctl stop com.flasksocket.uwsgi;
launchctl start com.flasksocket.uwsgi;
