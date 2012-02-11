class nfs::server::redhat inherits nfs::client::redhat {
  
  exec {"reload_nfs_srv":
    command     => "/etc/init.d/nfs reload",
    refreshonly => true,
    require     => Package["nfs-utils"]
  }

  service {"nfs":
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }

}
