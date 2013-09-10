class nfs::client {
  case $::operatingsystem {
    Ubuntu:         { include ::nfs::client::ubuntu}
    Debian:         { include ::nfs::client::debian}
    RedHat,CentOS:  { include ::nfs::client::redhat}
    default:        { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}

