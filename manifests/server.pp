#
# == Class: nfs::server
#
# Define an NFS server
#
class nfs::server(
  $service_enable  = true,
  $service_running = true,
) {
  case $::osfamily {
    'Debian': { include ::nfs::server::debian}
    'RedHat': { include ::nfs::server::redhat }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
