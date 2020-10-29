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

# comment out xdebug
sed -i -E 's/^zend/#zend/' /etc/php/$PHP_VERSION/cli/conf.d/20-xdebug.ini
sed -i -E 's/^zend/#zend/' /etc/php/$PHP_VERSION/fpm/conf.d/20-xdebug.ini
service php$PHP_VERSION-fpm restart
export XDEBUG_CONFIG="remote_enable=0 remote_mode=req remote_port=9000 remote_host=127.0.0.1 remote_connect_back=0"
echo "XDebug for php$PHP_VERSION disabled"

exit 0;
