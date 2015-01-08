# == Class: centreon
#
# This class enables you to provision one or several Centreon servers
# with Puppet, using Centreon CLAPI.
##
# === Parameters
#
#
#
# === Variables
#
#
#
# === Examples
#
#
#
# === Authors
#
# knak - Maxime VISONNEAU <maxime@visonneau.fr>
#
# === Copyright
#
# Apache V2 License
#

class centreon {
  include centreon::server, centreon::client, centreon::packages
}
