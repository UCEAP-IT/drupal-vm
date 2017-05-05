#!/bin/bash
#
# Example shell script to run pre-provisioning.
#
# This script configures the default CacheFS package to Speed Up
# Network File System (NFS) File Access.

# sudo apt-get install cachefilesd
sudo echo "RUN=yes" > /etc/default/cachefilesd
sudo chmod 0755 /etc/default/cachefilesd
