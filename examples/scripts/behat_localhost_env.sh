#!/bin/bash

## setup behat enviroment using base_url parameter
BASE_URL="${1:-myeap.local.logicbranch.com}"
VAGRANT_USER="${2:-vagrant}"
if [[ -z "${BEHAT_PARAMS}" ]]; then
  sudo su -c "echo \"BEHAT_PARAMS=\"{\"extensions\":{\"Behat\\\\MinkExtension\":{\"base_url\":\"http://$BASE_URL\"}}}\"\" >> /home/$VAGRANT_USER/.pam_environment" $VAGRANT_USER
fi
