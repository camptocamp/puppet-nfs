# ==Class: nfs::client
#
# This class configures NFS on client side
#
class nfs::client {
  case $::operatingsystem {
    'Ubuntu':                       { include ::nfs::client::ubuntu}
    'Debian':                       { include ::nfs::client::debian}
    /^(RedHat|CentOS|Scientific)$/: { include ::nfs::client::redhat}
    default:        { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}

