FROM wordpress:4.9.4-php7.1-fpm-alpine

MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>

# Add NewRelic PHP support
# Resource: https://github.com/mcuyar/docker-alpine-nginx-php7/blob/master/Dockerfile#L57-L64
RUN mkdir /tmp/newrelic && \
    cd /tmp/newrelic && \
    wget "https://download.newrelic.com/php_agent/release/$(curl -s https://download.newrelic.com/php_agent/release/ | grep -ohE 'newrelic-php5-.*?-linux-musl.tar.gz' | cut -f1 -d\")" -O php-agent.tar.gz && \
    gzip -dc php-agent.tar.gz | tar xf - && \
    mkdir -p /opt/newrelic && \
    cp -a "$(ls | grep newrelic)/." /opt/newrelic/ && \
    rm -rf /tmp/newrelic

# Install the gomplate utility to be able to generate templates
RUN wget -O /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v2.2.0/gomplate_linux-amd64-slim &&\
    chmod 755 /usr/local/bin/gomplate

# Add WP-CLI support
ENV WP_CLI_VERSION=1.5.0
RUN apk --update add less && \
    wget -O /tmp/wp-cli-${WP_CLI_VERSION}.phar https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar && \
    wget -O /tmp/wp-cli-${WP_CLI_VERSION}.phar.sha512 https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar.sha512 && \
    echo "$(cat /tmp/wp-cli-${WP_CLI_VERSION}.phar.sha512)  /tmp/wp-cli-${WP_CLI_VERSION}.phar" | sha512sum -cs - && \
    mv /tmp/wp-cli-${WP_CLI_VERSION}.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    rm -f /tmp/wp-cli-* && \
    mkdir -p /home/www-data/.wp-cli/ && \
    echo '---' >> /home/www-data/.wp-cli/config.yml && \
    echo 'path: /var/www/html' >> /home/www-data/.wp-cli/config.yml && \
    echo 'disabled_commands:' >> /home/www-data/.wp-cli/config.yml && \
    echo '  - db drop' >> /home/www-data/.wp-cli/config.yml && \
    chown -R www-data:www-data /home/www-data/.wp-cli/

# Copy script which will be executed before the original entrypoint
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.pre.sh

# Copy templates
COPY ./templates /templates

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.pre.sh"]
