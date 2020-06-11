#!/bin/sh

if [[ -n ${ZSH_NAME} ]]; then
   emulate -LR bash;
fi

cat /usr/local/var/log/flasktest.log;          # SHOW LOGFILE CONTENTS IN stdout
echo -n "" > /usr/local/var/log/flasktest.log; # ERASE FILE FOR NEXT TEST
