#!/bin/bash

## setup terminus post-provisioning given a machine token
##
## Usage: terminus.sh <machine token>
##
## This script ensure the installation of terminus and configures it to
## authenicates to pantheon given machine token parameter.

# Setup variables to installs terminus and it's plugin.
TERMINUS_COMMAND_NAME="terminus"
TERMINUS_DOWNLOAD="https://raw.githubusercontent.com/pantheon-systems/terminus-installer/master/builds/installer.phar"
TERMINUS_DOWNLOAD_DIR="/tmp/terminus"
TERMINUS_VERSION="1.3.x"
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
  curl -O $TERMINUS_DOWNLOAD && php installer.phar install  --install-dir=$TERMINUS_DOWNLOAD_DIR --bin-dir=$TERMINUS_COMPOSER_BIN_PATH
fi

# Install terminus helper plugins for workflow
if [ ! -e $TERMINUS_PLUGIN_PATH ]; then
  mkdir -p $TERMINUS_PLUGIN_PATH
  pushd $TERMINUS_PLUGIN_PATH
  git clone https://github.com/pantheon-systems/terminus-drupal-console-plugin.git
  git clone https://github.com/pantheon-systems/terminus-build-tools-plugin.git
  git clone https://github.com/pantheon-systems/terminus-composer-plugin.git
  git clone https://github.com/pantheon-systems/terminus-quicksilver-plugin.git
  popd
  chown -R $VAGRANT_USER:$VAGRANT_USER $TERMINUS_PLUGIN_PATH
fi

# Authenicate with provide machine token and push server aliases to drush
if [[ "$1" == "" ]]; then
	echo "Usage: terminus.sh <machine token> [<vagrant_user>]"
	exit 1
else
  $TERMINUS_COMPOSER_COMMAND auth:login --machine-token=$1
  $TERMINUS_COMPOSER_COMMAND aliases
fi
