FROM wordpress:4.8.0-php7.1-fpm

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
RUN apt-get update && \
    apt-get install -y wget && \
    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list && \
    apt-get update && \
    apt-get install -y newrelic-php5

# Copy script which will be executed before the original entrypoint
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.pre.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.pre.sh"]
