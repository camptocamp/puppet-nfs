class nfs::base {
  package { ["nfs-common", "portmap"]:
    ensure => present,
  }
}
