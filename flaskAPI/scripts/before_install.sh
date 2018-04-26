sudo apt-get update

sudo apt-get install -y \
    apache2 \
    apache2-dev \
    libapache2-mod-wsgi

if [ -d /var/www/html/flaskapp ]; then
  sudo rm -R /var/www/html/flaskapp
  sudo mkdir /var/www/html/flaskapp
fi
