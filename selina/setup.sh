#!/usr/bin/env bash

cd "/vagrant/scripts/"

# Useful func
source "_lib.sh"

# Start serious things here!

log "Update"
apt-get update

# Install default
. bootstrap.sh

log "Cleanup"
apt-get autoremove -y

# Install MySQL
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
package mysql-server

# Install PHP
. bootstrap_php.sh

# Setup Nginx
log "Setup Nginx"
. bootstrap_nginx.sh

cp "conf/nginx.conf" /etc/nginx/

rm -f /etc/nginx/conf.d/*
cp "conf/nginx.default.conf" /etc/nginx/conf.d/

service nginx restart

log "Setup complete!"
