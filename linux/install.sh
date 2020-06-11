UWSGIAPP=`which uwsgi`

sed 's/UWSGIAPP/${UWSGIAPP}/g' /etc/systemd/system/flaskapp.service
