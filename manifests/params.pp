class nfs::params {
  $portmap = $::osfamily? {
    Debian    => $::lsbdistcodename? {
      Wheezy  => 'rpcbind',
      default => 'portmap',
    },
    default   => 'portmap'
  }
}
