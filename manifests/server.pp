#
# == Class: nfs::server
#
# Define an NFS server
#
class nfs::server(
  $service_enable  = true,
  $service_running = true,
) {
  case $operatingsystem {
    Ubuntu:         { include nfs::server::ubuntu}
    Debian:         { include nfs::server::debian}
    RedHat,CentOS:  { include nfs::server::redhat }
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
