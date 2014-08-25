class centreon::server(
  $clapi_binaries     =  '/usr/local/centreon/www/modules/centreon-clapi/core',   # Centreon Server Hostname
  $clapi_username     =  'admin',                                                 # CLAPI Username
  $clapi_password     =  'password',                                              # CLAPI Password
  $clapi_export_file  =  '/tmp/clapi.conf',                                       # CLAPI Export file
  $clapi_log_file     =  '/var/log/centpollers.log',                              # CLAPI Log file
  $poller_name        =  'central',                                               # Poller name
) {

  include centreon::packages

  Centreon_host <<||>> {
    clapi_binaries => $clapi_binaries,
    clapi_username => $clapi_username,
    clapi_password => $clapi_password,
    clapi_export_file => $clapi_export_file,
    poller_name => $poller_name,
    notify => Service['centpollers'],
  }

  Centreon_service <<||>> {
    clapi_binaries => $clapi_binaries,
    clapi_username => $clapi_username,
    clapi_password => $clapi_password,
    clapi_export_file => $clapi_export_file,
    notify => Service['centpollers'],
  }

  service { 'centpollers':
    ensure   => 'running',
    provider => base,
    start    => '/etc/init.d/centpollers start',
    restart  => '/etc/init.d/centpollers restart',
    stop     => '/etc/init.d/centpollers stop',   # Dummy but needed
    status   => '/etc/init.d/centpollers status', # Dummy but needed
  }

  file { "/etc/init.d/centpollers":
    path    => "/etc/init.d/centpollers",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('centreon/centpollers.erb'),
    notify  => Service['centpollers'],
  }

  file { $clapi_export_file:
    ensure => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }
}