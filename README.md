# Docker Wordpress Image with Support for [NewRelic](http://newrelic.com/)

[![](https://imagelayers.io/badge/czerasz/wordpress-newrelic:latest.svg)](https://imagelayers.io/?images=czerasz/wordpress-newrelic:latest 'Get your own badge on imagelayers.io')

## Usage

Create data volume:

```bash
docker volume create --name=wordpress-data
```

```bash
docker run --name=wordpress \
           --env=NEWRELIC_LICENSE="<your license key>" \
           --env=NEWRELIC_APPNAME="<application name>" \
           --hostname=wordpress \
           --link=db:mysql \
           --volume=wordpress-data:/var/www/html \
           czerasz/wordpress-newrelic:latest
```

## Environment Variables

- `NEWRELIC_LICENSE` (**required**, default: not defined)
- `NEWRELIC_APPNAME` (**required**, default: not defined)

- `PHP_MEMORY_LIMIT` (default `96M`)
- `PHP_MAX_EXECUTION_TIME` (default `60`)
- `PHP_MAX_INPUT_VARS` (default `5000`)
- `PHP_UPLOAD_MAX_FILESIZE` (default `5M`)
- `PHP_POST_MAX_SIZE` (default `5M`)
- `PHP_LOG_LEVEL` (default `error`)
- `PHP_FPM_PM_MAX_CHILDREN` (default `10`)
- `PHP_FPM_PM_START_SERVERS` (default `2`)
- `PHP_FPM_PM_MIN_SPARE_SERVERS` (default `1`)
- `PHP_FPM_PM_MAX_SPARE_SERVERS` (default `3`)
- `PHP_FPM_PM_MAX_REQUESTS` (default `500`)
