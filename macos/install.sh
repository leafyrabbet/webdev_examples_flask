#!/bin/sh

if [[ -n ${ZSH_NAME} ]]; then
   emulate -LR bash;
fi

INSTALL_DIR=/usr/local/opt/flasktest;

mkdir -p ${INSTALL_DIR};
cp ../flasktest.ini ${INSTALL_DIR}/flasktest.ini;
cp ../flasktest.py ${INSTALL_DIR}/flasktest.py;
cp ../hello.mustache ${INSTALL_DIR}/hello.mustache;

cp com.flasksocket.uwsgi.plist /Library/LaunchDaemons/com.flasksocket.uwsgi.plist;
launchctl stop com.flasksocket.uwsgi;
launchctl unload /Library/LaunchDaemons/com.flasksocket.uwsgi.plist;
launchctl load /Library/LaunchDaemons/com.flasksocket.uwsgi.plist;
launchctl stop com.flasksocket.uwsgi;
launchctl start com.flasksocket.uwsgi;
