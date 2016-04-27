FROM wordpress:4.5.0-fpm

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
RUN apt-get update && \
    apt-get install -y wget && \
    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list && \
    apt-get update && \
    apt-get install -y newrelic-php5

# Copy script which will be executed before the original entrypoint
COPY ./entrypoint.sh /entrypoint.pre.sh

ENTRYPOINT ["/entrypoint.pre.sh"]
