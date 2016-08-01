#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install php5 ---"

package php5-dev
package php5-curl
package libpcre3-dev
package gcc
package php5-mysql
package php5-fpm
package php5-mysqlnd
package php5-curl
package php5-gd
package php5-intl
package php-pear
package php5-imagick
package php5-imap
package php5-mcrypt
package php5-memcache
package php5-pspell
package php5-recode
package php5-snmp
package php5-sqlite
package php5-tidy
package php5-xmlrpc
package php5-xsl

log "--- End: Install php5 ---"