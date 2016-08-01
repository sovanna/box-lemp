#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install supervisor ---"

BASE_SCRIPTS=${1:-"/vagrant/scripts"}
SUPERVISOR=${2:-supervisor.conf}

package supervisor

cp "$BASE_SCRIPTS/conf/$SUPERVISOR" "/etc/supervisor/conf.d/"

# Create Supervisor path to log files
if [ ! -d "/var/log/supervisord/" ]; then
  mkdir -p "/var/log/supervisord/"
  touch "/var/log/supervisord/supervisord.log"
fi

log "--- End: Install supervisor ---"