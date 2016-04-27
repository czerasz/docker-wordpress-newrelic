# Docker Wordpress Image with Support for [NewRelic](http://newrelic.com/)

[![](https://imagelayers.io/badge/czerasz/wordpress-newrelic:latest.svg)](https://imagelayers.io/?images=czerasz/wordpress-newrelic:latest 'Get your own badge on imagelayers.io')

## Usage

Create data volume:

```bash
docker volume create --name=wordpress-data
```

```bash
docker run --name=wordpress \
           --env-file=configuration/.env \
           --hostname=wordpress \
           --link=db:mysql \
           --volume=configuration/php/newrelic.ini:/usr/local/etc/php/conf.d/newrelic.ini:ro \
           --volume=wordpress-data:/var/www/html \
           czerasz/wordpress-newrelic:4.5.0-fpm
```

Where a `configuration/php/newrelic.ini` example is presented below:

```
;
; This file contains the various settings for the New Relic PHP agent. There
; are many options, all of which are described in detail at the following URL:
; https://newrelic.com/docs/php/php-agent-phpini-settings
;

extension = "newrelic.so"

[newrelic]

newrelic.license = "<your license key>"
newrelic.appname = "<application name>"
newrelic.framework = "wordpress"
```
