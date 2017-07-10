FROM wordpress:4.8.0-php7.1-fpm-alpine

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
# Resource: https://github.com/mcuyar/docker-alpine-nginx-php7/blob/master/Dockerfile#L57-L63
RUN mkdir /tmp/newrelic && \
    cd /tmp/newrelic && \
    wget "http://download.newrelic.com/php_agent/release/$(curl http://download.newrelic.com/php_agent/release/ | grep -ohE 'newrelic-php5-.*?-linux-musl.tar.gz' | cut -f1 -d\")" -O php-agent.tar.gz && \
    gzip -dc php-agent.tar.gz | tar xf - && \
    mkdir -p /opt/newrelic && \
    cp -a "$(ls | grep 'newrelic')/." /opt/newrelic/ && \
    rm -rf /tmp/newrelic

# Copy script which will be executed before the original entrypoint
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.pre.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.pre.sh"]
