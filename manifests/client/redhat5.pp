class nfs::client::redhat5 {
  package { "portmap":
    ensure => present,
    }    
    service { "portmap":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package["portmap"], Package["nfs-utils"]],
    }
}
