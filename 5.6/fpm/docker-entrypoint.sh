#!/bin/bash

# Render PHP configuration file
if [ $(env | grep -E '^PHP_' | wc -l) -gt 0 ]; then
  gomplate --file /templates/php-override.ini --out /usr/local/etc/php/conf.d/php-override.ini
fi

# Render NewRelic configuration file
if [ ! -z "$NEWRELIC_LICENSE" ] && [ ! -z "$NEWRELIC_APPNAME" ]; then
  gomplate --file /templates/newrelic.ini --out /usr/local/etc/php/conf.d/newrelic.ini
fi

# Initialize NewRelic APM
NR_INSTALL_SILENT=true NR_INSTALL_PHPLIST="/usr/local/bin" NR_INSTALL_PATH="/usr/local/bin" /usr/bin/newrelic-install install

# Continue with default image behaviour
/usr/local/bin/docker-entrypoint.sh php-fpm
