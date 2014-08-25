# puppet-centreon

## Overview

This module provides the provisioning of nodes onto one or several Centreon monitoring server through CLAPI.
It does not provide the installation of the Centreon server (yet).

## Requirements

* Stored configurations enabled on the puppetmaster (mandatory)

Stored configurations are essential on the puppetmaster for the module to work
at all, since it relies on having all nodes create their own exported nagios
host and service resources, which the nagios server node then realizes to
build its configuration.

## Sample Usage

Centreon server instance :

```puppet
    class { 'centreon::server':
	  clapi_binaries     =>  '/app/centreon/www/modules/centreon-clapi/core',
	  clapi_username     =>  'admin',
	  clapi_password     =>  'password',
	  clapi_export_file  =>  '/tmp/clapi.conf',
	  clapi_log_file     =>  '/var/log/centpollers.log',
	  poller_name        =>  'central',
    }
```

Centreon client instances :

```puppet
    class { 'centreon::client': }
```

## Roadmap

- I will be developing the centreon_host and centreon_service with all the possibilities that offers Centreon CLAPI. 