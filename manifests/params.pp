# Set default parameters based on distribution release
class nfs::params {
  $package::portmap = $::operatingsystem? {
    'Debian' => $::lsbdistcodename? {
      'Wheezy' => 'rpcbind',
      default  => 'portmap',
    },
    'Ubuntu' => 'rpcbind',
    default  => 'portmap'
  }
  $service::portmap = $::operatingsystem? {
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
