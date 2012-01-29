class nfs::client {
  case $operatingsystem {
    Debian:        { include nfs::client::debian}
    Ubuntu:        { include nfs::client::ubuntu}
    RedHat,CentOS: { include nfs::client::redhat}
    default:       { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

