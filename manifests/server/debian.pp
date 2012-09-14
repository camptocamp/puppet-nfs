class nfs::server::debian inherits nfs::client::debian {

  package {"nfs-kernel-server":
    ensure => present,
  }
  
  exec {"reload_nfs_srv":
    command     => "/etc/init.d/nfs-kernel-server reload",
    refreshonly => true,
    require     => Package["nfs-kernel-server"]
  }

  service {"nfs-kernel-server":
    enable  => "true",
    pattern => "nfsd"
  }

  concat {'/etc/exports':
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Exec['reload_nfs_srv'],
  }

}
