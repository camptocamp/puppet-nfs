# Set default parameters based on distribution release
class nfs::params {
  $portmap = $::operatingsystem? {
    'Debian' => versioncmp($::operatingsystemmajrelease, 7)? {
      1    => 'rpcbind',
      0    => 'rpcbind',
      '-1' => 'portmap',
    },
    'Ubuntu' => 'rpcbind',
    default  => 'portmap'
  }
}
