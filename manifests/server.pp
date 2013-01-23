class nfs::server(
  $service_enable = true,
) {
  case $operatingsystem {
    Debian:  { include nfs::server::debian }
    Ubuntu:  { include nfs::server::ubuntu }
    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
