# Set default parameters based on distribution release
class nfs::params {
  $portmap_package = $::operatingsystem? {
    'Debian' => $::lsbdistcodename? {
      'Wheezy' => 'rpcbind',
      default  => 'portmap',
    },
    'Ubuntu' => 'rpcbind',
    default  => 'portmap'
  }
  $portmap_service = $::operatingsystem? {
    'Debian' => $::lsbdistcodename? {
      'Wheezy' => 'rpcbind',
      default  => 'portmap',
    },
    'Ubuntu' => $::lsbdistcodename? {
      'trusty' => 'rpcbind',
      default  => 'portmap',
    },
    default  => 'portmap'
  }
}
