class nfs::server {
  case $operatingsystem {
    Debian:  { include nfs::server::debian }
    Ubuntu:  { include nfs::server::ubuntu }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
