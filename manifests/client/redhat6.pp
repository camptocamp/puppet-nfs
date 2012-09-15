class nfs::client::redhat6 {
  package {"rpcbind":
    ensure => present,
  }
  service {"rpcbind":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => [Package["rpcbind"], Package["nfs-utils"]],
  }
}
