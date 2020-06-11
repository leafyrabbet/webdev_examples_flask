USERUSER=`id -un`
USERGROUP=`id -gn`
UWSGIAPP=`which uwsgi | sed 's;\/;\\\/;g'`
echo ${UWSGIAPP}

sed 's/USERUSER/'"$USERUSER"'/g' flaskapp.service > flaskapp_built.service
sed 's/USERGROUP/'"$USERGROUP"'/g' flaskapp_built.service > flaskapp_built.service
sed 's/UWSGIAPP/'"$UWSGIAPP"'/g' flaskapp_built.service > flaskapp_built.service
