# ==Class: nfs::client
#
# This class configures NFS on client side
#
class nfs::client {
  case $::osfamily {
    'Debian': { include ::nfs::client::debian}
    'RedHat': { include ::nfs::client::redhat}
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}

