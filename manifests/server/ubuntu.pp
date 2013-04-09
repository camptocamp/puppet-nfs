class nfs::server::ubuntu inherits nfs::server::debian {
  Service['nfs-common'] {
    name => 'statd',
  }
  Package['portmap'] {
    name => 'rpcbind',
  }
}
