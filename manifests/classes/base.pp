class nfs::base {
  package { ["nfs-common", "portmap"]:
    ensure => present,
  }

  service { "nfs-common":
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  service { "portmap":
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }
}
