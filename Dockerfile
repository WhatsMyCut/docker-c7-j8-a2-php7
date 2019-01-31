FROM whatsmycut/docker-c7-j8-apache2:latest
LABEL maintainer="mike@whatsmycut.com"
LABEL imagename=whatsmycut/docker-c7-j8-a2-php7:latest
ADD ./ /usr/local/dev/
RUN chmod -R +x /usr/local/dev; ls -al /usr/local/dev
# Install PHP
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php72;
RUN yum -y update; yum -y install php php-opcache php-gd php-ldap php-odbc \
 php-pear php-xml php-xmlrpc php-mbstring php-soap php-mpm php-fpm curl curl-devel; \
 yum clean all;
RUN mkdir /usr/local/apache2/htdocs/vhosts/centos.local; \
mkdir /usr/local/apache2/htdocs/vhosts/centos.local/htdocs/;\
mkdir /usr/local/apache2/htdocs/vhosts/centos.local/logs/;
COPY phpinfo.php /usr/local/apache2/htdocs/vhosts/centos.local/htdocs/index.php
# RUN ["/bin/sh", "-c", "/usr/local/dev/install-php-src.sh"]
COPY 01-mpm.conf /etc/httpd/conf.d/01-mpm.conf
COPY 999-centos.local.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
RUN systemctl enable php-fpm; systemctl enable httpd;
EXPOSE 80
VOLUME ["/sys/fs/cgroup"]
ENTRYPOINT [ "/usr/local/dev/docker-entrypoint.sh", "/bin/sh", "-c", "php -version" ]
CMD ["/usr/sbin/init"]
