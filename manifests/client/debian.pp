class nfs::client::debian inherits nfs::base {

  package { ["nfs-common", "portmap"]:
    ensure => present,
  }
 
  service { "portmap":
    ensure    => running,
    enable    => true,
    hasstatus => false,
    require   => Package["portmap"],
  }

}
