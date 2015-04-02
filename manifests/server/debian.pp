# Specific settings for server on Debian
class nfs::server::debian inherits nfs::client::debian {

  package {'nfs-kernel-server':
    ensure => present,
  }

  service {'nfs':
    ensure  => $nfs::server::service_running,
    enable  => $nfs::server::service_enable,
    name    => 'nfs-kernel-server',
    pattern => 'nfsd',
    require => Package['nfs-kernel-server'],
  }

}
