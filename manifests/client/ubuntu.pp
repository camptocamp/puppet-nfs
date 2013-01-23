class nfs::client::ubuntu inherits nfs::client::debian {
  Service['nfs-common'] {
    name => 'statd'
  }
}
