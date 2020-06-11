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
