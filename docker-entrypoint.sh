#!/bin/bash
if [ "$#" -gt 1 ] && [ "$1" = /bin/sh ] && [ x"$2" = x"-c" ]; then
  shift 2
  eval "shift 2; set -- $1"
fi
# Exit on errors
set -e
# Uncomment to set the root password to login for runtime debugging.
passwd root
# Display chkconfig info
chkconfig --list
exec /usr/sbin/init
systemctl restart autofs
systemctl restart httpd
systemctl list-unit-files > /usr/local/tmp/unit-files.rpt
# run the command given as arguments from CMD
eval "$@"
