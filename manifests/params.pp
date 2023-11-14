# Set default parameters based on distribution release
class nfs::params {

  # These params only used by the nfs::client::debian class
  case $facts['os']['name'] {
    'Debian': {
      $portmap_service = 'rpcbind'
      $portmap_package = 'rpcbind'
      $statd_service   = 'rpc-statd'
      $portmap_enable = true
    }
    'Ubuntu': {
      $portmap_service = 'rpcbind'
      $portmap_package = 'rpcbind'
      $portmap_enable = undef
      $statd_service = 'rpc-statd'
    }
    default: {
      fail("Operating system not supported ${facts['os']['family']}")
    }
  }
}
