#!/bin/bash

# Render PHP configuration file
if [ $(env | grep -E '^PHP_' | wc -l) -gt 0 ]; then
  gomplate --file /templates/php-override.ini --out /usr/local/etc/php/conf.d/php-override.ini
  gomplate --file /templates/php-fpm-www-override.conf --out /usr/local/etc/php-fpm.d/php-fpm-www-override.conf
fi

if [ ! -z "$NEWRELIC_LICENSE" ] && [ ! -z "$NEWRELIC_APPNAME" ]; then
  # Copy NewRelic configuration file
  cp /templates/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini

  # Initialize NewRelic APM
  NR_INSTALL_SILENT=true NR_INSTALL_LOCATION='/opt/newrelic/' NR_INSTALL_PHPLIST="/usr/local/bin" NR_INSTALL_PATH="/usr/local/bin" /opt/newrelic/newrelic-install install
fi

# Continue with default image behaviour
/usr/local/bin/docker-entrypoint.sh php-fpm --force-stderr
