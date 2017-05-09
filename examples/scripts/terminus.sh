#!/bin/bash

## setup terminus post-provisioning given a machine token
##
## Usage: terminus.sh <machine token>
##
## This script ensure the installation of terminus and configures it to
## authenicates to pantheon given machine token parameter.

# Setup variables to installs terminus and it's plugin.
TERMINUS_COMMAND_NAME="terminus"
VAGRANT_USER="${2:-vagrant}"
TERMINUS_COMPOSER_VENDOR_PATH="/home/$VAGRANT_USER/.composer/vendor"
TERMINUS_COMPOSER_BIN_PATH="$TERMINUS_COMPOSER_VENDOR_PATH/bin"
TERMINUS_COMPOSER_COMMAND="$TERMINUS_COMPOSER_BIN_PATH/$TERMINUS_COMMAND_NAME"
TERMINUS_PLUGIN_PATH="/home/$VAGRANT_USER/.terminus/plugins"
# Check to see if we've already installed terminus.
if [ ! -e $TERMINUS_COMPOSER_COMMAND ]; then
  # Download and install terminus in composer global for current user.
  # add  '--install-version=$TERMINUS_VERSION' if you want to install a specific
  # terminus version.
  sudo su -c "cgr \"pantheon-systems/terminus:^1\"" $VAGRANT_USER
fi

# Install terminus helper plugins for workflow
if [ ! -e $TERMINUS_PLUGIN_PATH ]; then
  sudo su -c "mkdir -p $TERMINUS_PLUGIN_PATH" $VAGRANT_USER
  sudo su -c "composer create-project -n -d $TERMINUS_PLUGIN_PATH pantheon-systems/terminus-drupal-console-plugin:^1" $VAGRANT_USER
  sudo su -c "composer create-project -n -d $TERMINUS_PLUGIN_PATH pantheon-systems/terminus-build-tools-plugin:^1" $VAGRANT_USER
  sudo su -c "composer create-project -n -d $TERMINUS_PLUGIN_PATH pantheon-systems/terminus-secrets-plugin:^1" $VAGRANT_USER
  sudo su -c "composer create-project -n -d $TERMINUS_PLUGIN_PATH pantheon-systems/terminus-composer-plugin:^1" $VAGRANT_USER
  sudo su -c "composer create-project -n -d $TERMINUS_PLUGIN_PATH pantheon-systems/terminus-quicksilver-plugin:^1" $VAGRANT_USER
fi

# Authenicate with provide machine token and push server aliases to drush
if [[ "$1" == "" ]]; then
	echo "Usage: terminus.sh <machine token> [<vagrant_user>]"
	exit 1
else
  sudo su -c "$TERMINUS_COMPOSER_COMMAND auth:login --machine-token=$1" $VAGRANT_USER
  sudo su -c "$TERMINUS_COMPOSER_COMMAND aliases" $VAGRANT_USER
fi
