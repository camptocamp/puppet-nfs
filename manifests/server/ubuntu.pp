# Specific settings for server on Ubuntu
class nfs::server::ubuntu inherits nfs::server::debian {
  Service['nfs-common'] {
    name => 'statd',
  }
  Package[$nfs::params::portmap::package] { }
}
