# Specific settings for server on Debian
class nfs::server::debian inherits nfs::client::debian {

  package {'nfs-kernel-server':
    ensure => installed,
  }

  exec {'reload_nfs_srv':
    command     => '/etc/init.d/nfs-kernel-server reload',
    onlyif      => '/etc/init.d/nfs-kernel-server status',
    refreshonly => true,
    require     => Package['nfs-kernel-server'],
  }

  service {'nfs-kernel-server':
    ensure  => $nfs::server::service_running,
    enable  => $nfs::server::service_enable,
    pattern => 'nfsd',
  }

  @concat {'/etc/exports':
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Exec['reload_nfs_srv'],
  }

}
