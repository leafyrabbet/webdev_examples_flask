mv flaskapp_built.service /etc/systemd/system/flaskapp.service

mkdir -p /var/www/flaskapp/
cp ../flask_app.ini /var/www/flaskapp/
cp ../flask_app.py /var/www/flaskapp/
cp ../hello.mustache /var/www/flaskapp/
