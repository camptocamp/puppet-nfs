class nfs::server(
  $service_enable = true,
) {
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }
}
