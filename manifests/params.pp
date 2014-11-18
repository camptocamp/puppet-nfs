# Set default parameters based on distribution release
class nfs::params {
  $portmap = $::osfamily? {
      'Debian'    => $::lsbdistcodename? {
      'Wheezy'  => 'rpcbind',
      default => 'portmap',
    },
    'Ubuntu'   => 'rpcbind',
    default  => 'portmap'
  }
}
