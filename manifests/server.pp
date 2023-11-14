#
# == Class: nfs::server
#
# Define an NFS server
#
class nfs::server(
  $service_enable  = true,
  $service_running = true,
) {
  case $facts['os']['family'] {
    'Debian': { include nfs::server::debian }
    'RedHat': { include nfs::server::redhat }
    default: { notice "Unsupported operating system ${facts['os']['family']}" }
  }
}
