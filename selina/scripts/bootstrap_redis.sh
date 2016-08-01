#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install redis ---"

BASE_SCRIPTS=${1:-"/vagrant/scripts"}
REDIS_MASTER=${2:-redis-master.conf}
REDIS_SENTINEL=${3:-none}

cd $BASE_SCRIPTS

if [[ ! -e "/usr/local/bin/redis-server" ]]; then

  if [[ ! -f "$BASE_SCRIPTS/redis-stable.tar.gz" ]]; then
    wget "http://download.redis.io/redis-stable.tar.gz"
  fi

  tar xvzf redis-stable.tar.gz
  cd "redis-stable"

  make
  make install

  cd "../"

  rm -rf "redis-stable"
  rm -f "redis-stable.tar.gz"

  mkdir -p "/etc/redis/"
  mkdir -p "/var/redis/6379/"
fi

cp "$BASE_SCRIPTS/conf/$REDIS_MASTER" "/etc/redis/6379.conf"

if [[ ! $REDIS_SENTINEL == "none" ]]; then
  cp "$BASE_SCRIPTS/conf/$REDIS_SENTINEL" "/etc/redis/6379-sentinel.conf"
fi

cd $BASE_SCRIPTS

log "--- End: Install redis ---"