#!/bin/sh

if [[ -n ${ZSH_NAME} ]]; then
   emulate -LR bash;
fi

INSTALL_DIR=/usr/local/opt/flasktest;

mkdir -p ${INSTALL_DIR};
cp ../flask_app.ini ${INSTALL_DIR}/flask_app.ini;
cp ../flask_app.py ${INSTALL_DIR}/flask_app.py;
cp ../hello.mustache ${INSTALL_DIR}/hello.mustache;

cp com.flasktest.uwsgi.plist ~/Library/LaunchAgents/com.flasktest.uwsgi.plist;
launchctl unload ~/Library/LaunchAgents/com.flasktest.uwsgi.plist;
launchctl load ~/Library/LaunchAgents/com.flasktest.uwsgi.plist;
launchctl stop com.flasktest.uwsgi;
launchctl start com.flasktest.uwsgi;
