import "classes/*.pp"
import "definitions/*.pp"

class nfs::client {
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::client::debian}
    RedHat,CentOS:  { include nfs::client::redhat}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}

class nfs::server {
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
