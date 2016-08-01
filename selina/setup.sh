#!/usr/bin/env bash

BASE_SCRIPTS="/vagrant/scripts"

cd "$BASE_SCRIPTS/"

# Useful func
source "_lib.sh"

# Start serious things here!

log "Update"
apt-get update

# Install default
source bootstrap.sh

# Install redis
source bootstrap_redis.sh $BASE_SCRIPTS "redis-master.conf"

cd "$BASE_SCRIPTS/"

# Install Supervisor
source bootstrap_supervisor.sh $BASE_SCRIPTS "supervisor_katie-m.conf"

# Install MySQL
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
package mysql-server

# Install PHP
source bootstrap_php.sh

# Setup Nginx
log "Setup Nginx"
source bootstrap_nginx.sh $BASE_SCRIPTS

cp "$BASE_SCRIPTS/conf/nginx.conf" "/etc/nginx/"
rm -f "/etc/nginx/conf.d/default.conf"
cp "$BASE_SCRIPTS/conf/nginx.default.conf" "/etc/nginx/conf.d/"

service nginx stop
service nginx start

service supervisor stop
service supervisor start

log "Setup complete!"
