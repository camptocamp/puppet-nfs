# Set default parameters based on distribution release
class nfs::params {
  $portmap::package = $::operatingsystem? {
    'Debian' => $::lsbdistcodename? {
      'Wheezy' => 'rpcbind',
      default  => 'portmap',
    },
    'Ubuntu' => 'rpcbind',
    default  => 'portmap'
  }
  $portmap::service = $::operatingsystem? {
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
