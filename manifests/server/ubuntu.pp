# Specific settings for server on Ubuntu
class nfs::server::ubuntu inherits nfs::server::debian {
  Package[$nfs::params::portmap] { }
}
