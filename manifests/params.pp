# Set default parameters based on distribution release
class nfs::params {
  $portmap = $::operatingsystem? {
    'Debian' => $::lsbdistcodename? {
      'Wheezy' => 'rpcbind',
      'Jessie' => 'rpcbind',
      default  => 'portmap',
    },
    'Ubuntu' => 'rpcbind',
    default  => 'portmap'
  }
}
