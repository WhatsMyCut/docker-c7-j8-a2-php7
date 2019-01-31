#!/bin/bash

# Install PHP
yum -y install re2c bison libxml2-devel bzip2-devel libcurl-devel libpng-devel libicu-devel gcc-c++ libmcrypt-devel libwebp-devel libjpeg-devel openssl-devel
curl -LO http://www.php.net/distributions/php-7.3.1.tar.gz;
tar -xzf php-7.3.1.tar.gz;
rm *.gz;
cd php-7.3.1;
./buildconf --force
./configure --prefix=/usr/local/php --enable-fpm --enable-short-tags --with-pcre-regex --with-pcre-jit --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --with-gd --enable-intl --enable-mbstring --with-mysqli --enable-pcntl --with-pdo-mysql --enable-soap --enable-sockets --with-xmlrpc --enable-zip --without-libzip --with-webp-dir --with-jpeg-dir --with-png-dir
make;
#make test;
make install;
export PATH=/usr/local/php/bin:$PATH
/php-7.3.1/build/shtool install -c ext/phar/phar.phar /usr/local/php/bin;
ln -s -f phar.phar /usr/local/php/bin/phar
