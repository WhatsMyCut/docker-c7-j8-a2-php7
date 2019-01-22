FROM whatsmycut/docker-c7-j8-apache2:latest
LABEL maintainer "mike@whatsmycut.com"
ADD . /usr/local/dev/
RUN chmod -R +x /usr/local/dev; ls -al /usr/local/dev
# Install PHP
RUN ["/bin/sh", "-c", "/usr/local/dev/install-php-src.sh"]
EXPOSE 80 443
VOLUME ["/sys/fs/cgroup"]
ENTRYPOINT [ "/usr/sbin/init" ]
CMD ["systemctl", "restart", "autofs"]
