# ==Class: nfs::client
#
# This class configures NFS on client side
#
class nfs::client {
  case $facts['os']['family'] {
    'Debian': { include nfs::client::debian }
    'RedHat': { include nfs::client::redhat }
    default: { notice "Unsupported operating system ${facts['os']['family']}" }
  }
}

