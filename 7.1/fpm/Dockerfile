FROM wordpress:4.9.4-php7.1-fpm

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* &&\
    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list && \
    apt-get update && \
    apt-get install -y newrelic-php5

# Install the gomplate utility to be able to generate templates
RUN wget -O /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v2.2.0/gomplate_linux-amd64-slim &&\
    chmod 755 /usr/local/bin/gomplate

# Copy script which will be executed before the original entrypoint
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.pre.sh

# Copy templates
COPY ./templates /templates

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.pre.sh"]
