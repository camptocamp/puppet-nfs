# Specific settings for client on Ubuntu
class nfs::client::ubuntu inherits nfs::client::debian {

  if versioncmp($::operatingsystemrelease, '16.04') >= 0 {
    $service_name = 'rpc-statd'
  } else {
    $service_name = 'statd'
  }

  Service['nfs-common'] {
    name => $service_name,
  }
  Package[$nfs::params::portmap] { }
}
