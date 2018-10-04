#!/bin/sh
set -e

if [ ! -e piwik.php ]; then
	tar cf - --one-file-system -C /usr/src/piwik . | tar xf -
	chown -R www-data .
fi

sed -i -e "s/pm.max_children = 5/pm.max_children = 200/g" $PHP_INI_DIR/../php-fpm.d/www.conf && \
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" $PHP_INI_DIR/../php-fpm.d/www.conf && \
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" $PHP_INI_DIR/../php-fpm.d/www.conf && \
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 10/g" $PHP_INI_DIR/../php-fpm.d/www.conf && \
sed -i -e "s/pm.max_requests = 500/pm.max_requests = 1000/g" $PHP_INI_DIR/../php-fpm.d/www.conf

exec "$@"
