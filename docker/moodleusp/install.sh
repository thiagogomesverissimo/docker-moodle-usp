#!/bin/bash

set -e

MOODLE_DIR="/var/www/html/moodle"
MOODLEDATA="/var/www/html/moodledata"

mkdir -p "$MOODLEDATA"

echo "Aguardando MariaDB..."

until php -r "
\$mysqli = @new mysqli(
    'mariadb',
    'moodleusp',
    'moodleusp',
    'moodleusp'
);
exit(\$mysqli->connect_errno ? 1 : 0);
"; do
    sleep 2
done

echo "MariaDB disponível"

if [ ! -f "$MOODLE_DIR/config.php" ]; then
    echo "Instalando Moodle..."

    php "$MOODLE_DIR/admin/cli/install.php" \
        --lang=pt_br \
        --wwwroot=http://localhost:8000 \
        --dataroot="$MOODLEDATA" \
        --dbtype=mariadb \
        --dbhost=mariadb \
        --dbname=moodleusp \
        --dbuser=moodleusp \
        --dbpass=moodleusp \
        --fullname="Moodle USP" \
        --shortname="MoodleUSP" \
        --adminuser=admin \
        --adminpass='Admin123!' \
        --adminemail='admin@example.com' \
        --non-interactive \
        --agree-license
fi