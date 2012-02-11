class nfs::server {
  include concat::setup
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    RedHat,CentOS,scientific,oel:  { include nfs::server::redhat}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
