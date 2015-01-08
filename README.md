# puppet-centreon

[![Puppet Forge](https://img.shields.io/puppetforge/v/knak/centreon.svg?style=flat-square)](https://forge.puppetlabs.com/knak/centreon)

## Overview

This module provides the provisioning of nodes onto one or several Centreon monitoring server through CLAPI.
It works whatever the engine/broker you use : Nagios, Shinken and Centreon Engine / NDO2DB and Centreon Broker

## Limitations

* It does not provide the installation of the Centreon server (yet).
* You can use only one poller for the moment
* Configuration of hosts and services only

## Requirements

* At least one Centreon server up and running ( >= 2.0 ) with the CLAPI module configured ( >= 1.6 )
* Stored configurations enabled on the puppetmaster (mandatory)

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

## Types definitions

Centreon HOST : centreon_host :

```puppet
centreon_host { 'resource title':
	clapi_binaries 		=> # MANDATORY - CLAPI Binaries
    clapi_username 		=> # MANDATORY - CLAPI Username
    clapi_password 		=> # MANDATORY - CLAPI Password
    clapi_export_file 	=> # MANDATORY - CLAPI Exportfile
    poller_name 		=> # MANDATORY - Name of Centreon Poller
    alias 				=> # MANDATORY - Alias of the host
    address 			=> # MANDATORY - IP Address
    template 			=> # MANDATORY - Host template to use, must be defined in Centreon to avoid config errors
    ensure 				=> # MANDATORY - Whether the host is present or not into the configfile
    enabled             => # OPTIONAL  - Set the status of the host (true or false - default:true)
  }
```

Centreon Service : centreon_service :

```puppet
centreon_service { 'resource title':
	clapi_binaries 		=> # MANDATORY - CLAPI Binaries
    clapi_username 		=> # MANDATORY - CLAPI Username
    clapi_password 		=> # MANDATORY - CLAPI Password
    clapi_export_file 	=> # MANDATORY - CLAPI Exportfile
    hostname 			=> # MANDATORY - Hostname of the host to map the service on
    description 		=> # MANDATORY - Description of the service ( servicename in Centreon )
    template 			=> # MANDATORY - Service template to use, must be defined in Centreon to avoid config errors
    ensure 				=> # MANDATORY - Whether the service is present or not into the configfile
    enabled             => # OPTIONAL  - Set the status of the service (true or false - default:true)
    check_command 		=> # OPTIONAL  - Check command to override the template
  }
```

## Classes definitions

centreon::server :

```puppet
    class { 'centreon::server':
	  clapi_binaries     =>  # MANDATORY - CLAPI Binaries path
	  clapi_username     =>  # MANDATORY - CLAPI Username
	  clapi_password     =>  # MANDATORY - CLAPI Password
	  clapi_export_file  =>  # MANDATORY - Path to export config from CLAPI as cache
	  clapi_log_file     =>  # MANDATORY - CLAPI Log file
	  poller_name        =>  # MANDATORY - Name of Centreon poller to provision the hosts
    }
```

centreon::client :

```puppet
    class { 'centreon::client': }
```

## Roadmap

- Add the possibility to split the provisioning onto multiple pollers.
- Implement the centreon_host and centreon_service with all the possibilities that offers Centreon CLAPI.
- Implement the other configuration definitions available with Centreon CLAPI