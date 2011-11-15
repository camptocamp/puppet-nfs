class nfs::server {
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
