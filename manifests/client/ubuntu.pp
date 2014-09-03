class nfs::client::ubuntu inherits nfs::client::debian {
  Service['nfs-common'] {
    name => 'statd'
  }
  Package['portmap'] {
    name => 'rpcbind'
  }
  if $::operatingsystemrelease > 13.10 {
    Service['portmap'] {
      name => 'rpcbind'
    }
  }
}
