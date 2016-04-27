#!/bin/bash

# Initialize NewRelic APM
NR_INSTALL_SILENT=true NR_INSTALL_PHPLIST="/usr/local/bin" NR_INSTALL_PATH="/usr/local/bin" /usr/bin/newrelic-install install

# Continue with default image behaviour
/entrypoint.sh php-fpm
