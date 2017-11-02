FROM wordpress:4.8.2-php7.1-fpm-alpine

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
# Resource: https://github.com/mcuyar/docker-alpine-nginx-php7/blob/master/Dockerfile#L57-L64
RUN mkdir /tmp/newrelic && \
    cd /tmp/newrelic && \
    wget "https://download.newrelic.com/php_agent/release/$(curl -s https://download.newrelic.com/php_agent/release/ | grep -ohE 'newrelic-php5-.*?-linux-musl.tar.gz' | cut -f1 -d\")" -O php-agent.tar.gz && \
    gzip -dc php-agent.tar.gz | tar xf - && \
    mkdir -p /opt/newrelic && \
    cp -a "$(ls | grep 'newrelic')/." /opt/newrelic/ && \
    rm -rf /tmp/newrelic

# Install the gomplate utility to be able to generate templates
RUN wget -O /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v2.1.0/gomplate_linux-amd64-slim &&\
    chmod 755 /usr/local/bin/gomplate

# Copy script which will be executed before the original entrypoint
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.pre.sh

# Copy templates
COPY ./templates /templates

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.pre.sh"]
