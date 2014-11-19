# Specific settings for client on Ubuntu
class nfs::client::ubuntu inherits nfs::client::debian {
  Service['nfs-common'] {
    name => 'statd',
  }
  Package[$nfs::params::portmap] { }
}
