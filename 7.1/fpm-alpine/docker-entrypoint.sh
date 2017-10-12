#!/bin/bash

# Render PHP configuration file
gomplate --file /templates/php-override.ini --out /usr/local/etc/php/conf.d/php-override.ini

# Render NewRelic configuration file
if [ ! -z "$NEWRELIC_LICENSE" ] && [ ! -z "$NEWRELIC_APPNAME" ]; then
  gomplate --file /templates/newrelic.ini --out /usr/local/etc/php/conf.d/newrelic.ini
fi

# Initialize NewRelic APM
NR_INSTALL_SILENT=true NR_INSTALL_PHPLIST="/usr/local/bin" NR_INSTALL_PATH="/usr/local/bin" /opt/newrelic/newrelic-install install

# Continue with default image behaviour
/usr/local/bin/docker-entrypoint.sh php-fpm
