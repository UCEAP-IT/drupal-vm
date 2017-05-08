# Pantheon Cloud Drupal VM Configuration Example

This directory contains example configuration overrides for our Drupal VM `default.config.yml` file which will emulate the default Pantheon Cloud environment with Drupal VM:

  - Ubuntu 16.04
  - Nginx 1.10.3
  - PHP 7.1
  - MariaDB 10.0.29
  - Apache Solr 5.5.3

To use these overrides, copy `reciprocity-config.yml` to `config.yml`, and by looking at `default.config.yml` add any other overrides you'd like. Whatever variables you have set in `config.yml` will override the defaults set by `default.config.yml`.

Use the Main Drupal VM Quick start guide to get [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) up and running.
[`drupal-vm quick-start-guide`](https://github.com/geerlingguy/drupal-vm#quick-start-guide)

You will also want [Ansible](http://docs.ansible.com/intro_installation.htm) and the Vagrant plugins(vagrant-hostsupdater and vagrant-vbguest) to help setup your host system configurations vs hand editing.

See the Drupal VM guide's the following sections for more details:

[`Install Vagrant and VirtualBox Notes:`](https://github.com/geerlingguy/drupal-vm#1---install-vagrant-and-virtualbox)

[`Configure your host machine to access the VM`](https://github.com/geerlingguy/drupal-vm#3---configure-your-host-machine-to-access-the-vm)

Finally you will want to add a Pantheon terminus machine token for the vm to the `terminus_machine_token:` section of the `/config.yaml` to have it sign you into pantheon automatically when the VM is booted up.  
