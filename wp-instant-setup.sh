#!/usr/bin/env bash

set -ex;

DB_NAME=${1-wpdev}
DB_USER=${2-root}
DB_PASS=$3
PORT=8080
WP_PATH=$(pwd)/www
WP_TITLE="Welcome to the WordPress"
WP_DESC="Hello World!"

if [ -e "$WP_PATH/wp-config.php" ]; then
    php -S 127.0.0.1:$PORT -t $WP_PATH
    exit 0
fi

wp() {
    bin/wp $*
}

echo "Download wp-cli"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
mkdir bin
mv wp-cli.phar bin/wp
chmod 755 bin/wp

echo "path: $WP_PATH" > $(pwd)/wp-cli.yml

echo "DROP DATABASE IF EXISTS $DB_NAME;" | mysql -u root
echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql -u root

wp core download --path=$WP_PATH --locale=en_US --force

if [ $DB_PASS ]; then
wp core config \
--dbhost=localhost \
--dbname=$DB_NAME \
--dbuser=$(printf "%s" $DB_USER) \
--dbpass=$(printf "%s" $DB_PASS) \
--dbprefix=wp_ \
--locale=en_US \
--extra-php <<PHP
define( 'JETPACK_DEV_DEBUG', true );
define( 'WP_DEBUG', true );
PHP
else
wp core config \
--dbhost=localhost \
--dbname=$DB_NAME \
--dbuser=$(printf "%s" $DB_USER) \
--dbprefix=wp_ \
--locale=en_US \
--extra-php <<PHP
define( 'JETPACK_DEV_DEBUG', true );
define( 'WP_DEBUG', true );
PHP
fi

wp core install \
--url=http://127.0.0.1:$PORT \
--title=$(printf "%s" $WP_TITLE) \
--admin_user="admin" \
--admin_password="admin" \
--admin_email="admin@example.com"

wp rewrite structure "/archives/%post_id%"

wp option update blogdescription $(printf "%s" $WP_DESC)

wp theme install twentyfifteen --activate

php -S 127.0.0.1:$PORT -t $WP_PATH
