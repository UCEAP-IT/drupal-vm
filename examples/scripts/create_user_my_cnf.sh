#!/bin/bash

## setup mysql/mariadb client enviroment to login with using user & password parameters
USER="${1:-drupal}"
PASSWORD="${2:-drupal}"
MY_CNF_PATH="/home/${3:-vagrant}/.my.cnf"
if [ ! -e $MY_CNF_PATH ]; then
  printf "[client]\nuser=$USER\npassword=$PASSWORD" > $MY_CNF_PATH
  chmod 0600 $MY_CNF_PATH
else
  echo "$MY_CNF_PATH already exists please add your credentials to it manually"
  echo "if you haven't already and want to want to automatically login in the vm"
fi
