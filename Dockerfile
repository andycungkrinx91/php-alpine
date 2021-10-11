ARG BASE_IMAGE_TAG=3.14

FROM alpine:${BASE_IMAGE_TAG}

LABEL maintainer="Andy Cungkrinx <andy.silva270114@gmail.com>" \
    version.alpine="3.14" \
    version.php="7.4" 

# Add user
RUN mkdir /var/www; \
    addgroup -S app -g 1000; \
    adduser -u 1000 -h /home/app -s /bin/ash -G app -S app; \
    chown app:app /var/www -R;

# Install packages 
RUN apk --no-cache update; \
    apk --no-cache add \
	php7 \
	php7-fpm \
	php7-common \
	php7-pear \
	php7-tokenizer \
	php7-phpdbg \
    php7-pdo_mysql \
    php7-xsl \
    php7-dev \
    php7-xmlrpc \
    php7-mbstring \
    php7-xmlreader \
    php7-xmlwriter \
    php7-opcache \
    php7-ldap \
    php7-posix \
    php7-session \
    php7-gd \
    php7-json \
    php7-xml \
    php7-curl \
    php7-phar \
    php7-iconv \
    php7-zip \
    php7-cgi \
    php7-bcmath \
    php7-dom \
    php7-soap \
    php7-sockets \
    php7-pdo \
    php7-bz2 \
    php7-mysqli \
    php7-odbc \
    php7-sodium \
    php7-intl \
    php7-imap \
    php7-opcache \
    zlib \
    libpng \
    musl \
    libmcrypt \
    openssl \
    tzdata \
    wget \
    tar \
    curl \
    openssh \
    jpegoptim \
    optipng \
    gifsicle; \
    \
    # Install Ioncube
    cd /tmp; \
    wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64_10.4.1.tar.gz; \
    tar -zxvf ioncube_loaders*; \
    cp /tmp/ioncube/ioncube_loader_lin_7.4.so /usr/lib/php7/modules/ioncube_loader_lin_7.4.so; \
    \
    # Install Mcrypt
    apk add --no-cache -t .build-deps \
    gcc \
    make \
    autoconf \
    libmcrypt-dev \
    libc-dev \
    musl-dev; \
    pecl install mcrypt-1.0.3; \
    echo "extension=mcrypt.so" > /etc/php7/conf.d/00_mcrypt.ini; \
    apk del --purge .build-deps
# Copy Config for php
COPY config/php.ini /etc/php7/php.ini
COPY config/fpm/php-fpm.conf /etc/php7/php-fpm.conf
COPY config/fpm/www.conf /etc/php7/php-fpm.d/www.conf
COPY config/custom.ini /etc/php7/conf.d/custom.ini

RUN apk del \
    wget \
    tar; \
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/*; \
    ln -sf /dev/stdout /var/log/php7/access.log; \
    ln -sf /dev/stdout /var/log/php7/slow.log; \
    ln -sf /dev/stderr /var/log/php7/error.log; \
    cat /dev/null > /root/.ash_history && exit;

CMD ["php-fpm7", "-F"]
USER app
WORKDIR /var/www
EXPOSE 9000
