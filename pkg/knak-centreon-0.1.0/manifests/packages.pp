class centreon::packages {
  $centreonPackages = [ 'nagios-plugins','nagios-plugins-standard','nagios-plugins-basic' ]

  package {  $centreonPackages:
    ensure => installed,
  }
}