class nfs::client {
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::client::debian}
    RedHat,CentOS:  { include nfs::client::redhat}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

