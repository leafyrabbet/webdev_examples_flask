UWSGIAPP=`which uwsgi | sed 's;\/;\\\/;g'`
echo ${UWSGIAPP}

sed 's/UWSGIAPP/'"$UWSGIAPP"'/g' flaskapp.service > flaskapp_built.service
