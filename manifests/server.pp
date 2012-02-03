class nfs::server {
  include concat::setup
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    RedHat,CentOS,Scientific,oel:  { include nfs::server::redhat}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
