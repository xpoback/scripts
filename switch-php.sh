# check if sudo
if [ ! ${EUID:-$(id -u)} -eq 0 ]; then
  >&2 echo "This command must be run under sudo permissions";
  exit 1;
fi;

PHP_VERSION=$1

if [ ! $PHP_VERSION ]; then
  >&2 echo "PHP version must be specified as first argument";
  exit 1;
fi;

# switch console
ln -sf /usr/bin/php$PHP_VERSION /usr/bin/php

# switch fpm in nginx
sed -i -E "s/php[5|7|8].[0-9]-fpm.sock/php$PHP_VERSION-fpm.sock/" /etc/nginx/snippets/php-fpm.conf
service php$PHP_VERSION-fpm restart
service nginx restart

exit 0;
