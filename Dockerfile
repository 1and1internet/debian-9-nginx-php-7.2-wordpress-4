FROM 1and1internet/debian-9-nginx-php-7.2:latest
MAINTAINER brian.wilkinson@1and1.co.uk
ARG DEBIAN_FRONTEND=noninteractive

COPY files/ /

# Environment variables for the MySQL DB
ENV WORDPRESS_DB_HOST=mysql \
    WORDPRESS_DB_USER=username \
    WORDPRESS_DB_NAME=databasename \
    WORDPRESS_DB_PASSWORD=EnvVarHere \
    WORDPRESS_DB_PREFIX='wp_'

RUN \
    apt-get update && \
    apt-get install -y unzip libpng-dev libjpeg-dev php7.2-gd php7.2-mysql curl && \
    rm -rf /var/lib/apt/lists/* && \
    WORDPRESS_DOWNLOAD=$(curl -fsL https://wordpress.org/download/release-archive/ | grep -Eo 'https://wordpress.org/wordpress-4.[0-9\.]{1,4}.tar.gz' | sed 's/\.tar\.gz//' | sort -nr | uniq | head -1) && \
    curl -fsL $WORDPRESS_DOWNLOAD.tar.gz -o /usr/src/wordpress.tar.gz && \
    chmod -R 755 /hooks /init && \
    chmod 666 /etc/nginx/sites-enabled/site.conf
