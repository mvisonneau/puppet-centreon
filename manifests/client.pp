class centreon::client {
  include centreon::packages

  # Host declaration
  @@centreon_host { $hostname:
    alias => $hostname,
    address => $ipaddress,
    template => "generic-host",
    ensure => present,
  }

  # Service declaration
  @@centreon_service { "check_ping_${hostname}":
    hostname => "$hostname",
    template => "Ping-LAN",
    description => "ping",
    ensure => present,
  }
}