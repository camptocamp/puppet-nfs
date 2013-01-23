class nfs::server(
  $service_enable = true,
) {
  case $operatingsystem {
    Ubuntu:         { include nfs::server::ubuntu}
    Debian:         { include nfs::server::debian}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
