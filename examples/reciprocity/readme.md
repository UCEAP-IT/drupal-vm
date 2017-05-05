# Pantheon Cloud Drupal VM Configuration Example

This directory contains example configuration overrides for the default Drupal VM `default.config.yml` file which emulate the default Pantheon Cloud environment with Drupal VM:

  - Ubuntu 16.04
  - Nginx 1.10.3
  - PHP 7.1
  - MariaDB 10.0.29
  - Apache Solr 5.5.3

To use these overrides, copy `pantheon.config.yml` to `config.yml`, and by looking at `default.config.yml` add any other overrides you'd like. Whatever variables you have set in `config.yml` will override the defaults set by `default.config.yml`.
