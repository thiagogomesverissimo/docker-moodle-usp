#!/bin/bash

set -e

MOODLE_DIR="/var/www/html/moodle"
MOODLEDATA="/var/www/html/moodledata"

# Variáveis do SMTP / Mailpit
MAIL_HOST="mailpit"
MAIL_PORT="1025"
MAIL_ENCRYPTION="none" # Moodle utiliza 'none', 'ssl' ou 'tls'
MAIL_FROM_ADDRESS="moodleusp@example.com"

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

    echo "Configurando SMTP (Mailpit)..."
    php "$MOODLE_DIR/admin/cli/cfg.php" --name=smtphosts --set="${MAIL_HOST}:${MAIL_PORT}"
    php "$MOODLE_DIR/admin/cli/cfg.php" --name=smtpsecure --set="${MAIL_ENCRYPTION}"
    php "$MOODLE_DIR/admin/cli/cfg.php" --name=noreplyaddress --set="${MAIL_FROM_ADDRESS}"
fi