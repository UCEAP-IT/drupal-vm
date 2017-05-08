#!/bin/bash

## setup mysql/mariadb client enviroment to login with using user & password parameters
PHP_VERSION="${1:-7.1}"
PHP_FPM_SERVICE_NAME="php$PHP_VERSION-fpm"
YAML_INI_PATH="/etc/php/$PHP_VERSION/fpm/conf.d/20-yaml.ini"
if [ -e $YAML_INI_PATH]; then
  sudo sh -c "printf \";remove YAML to avoid myeap parse config exports errors\n;should be re-enabled once resolved\n;extension=yaml.so\" > $YAML_INI_PATH"
  # Restart PHP FPM.
  sudo service $PHP_FPM_SERVICE_NAME restart
fi
