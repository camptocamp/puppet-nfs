# Set default parameters based on distribution release
class nfs::params {

  # These params only used by the nfs::client::debian class
  case $::operatingsystem {
    'Debian': {
      case $::lsbdistcodename {
        'squeeze': {
          $portmap_service = 'portmap'
          $portmap_package = 'portmap'
          $statd_service   = 'nfs-common'
        }
        'stretch', 'buster': {
          $portmap_service = 'rpcbind'
          $portmap_package = 'rpcbind'
          $statd_service   = 'rpc-statd'
        }
        default: {
          $portmap_service = 'rpcbind'
          $portmap_package = 'rpcbind'
          $statd_service   = 'nfs-common'
        }
      }
      $portmap_enable = true
    }
    'Ubuntu': {
      $portmap_service = 'rpcbind'
      $portmap_package = 'rpcbind'
      if versioncmp($::operatingsystemrelease, '16.04') >= 0 {
        $portmap_enable = undef
        $statd_service = 'rpc-statd'
      } else {
        $portmap_enable = true
        $statd_service = 'statd'
      }
    }
    default: {
      fail("Operating system not supported ${::operatingsystem}")
    }
  }
}
