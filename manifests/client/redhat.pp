class nfs::client::redhat inherits nfs::base {

  package { "nfs-utils":
    ensure => present,
  }

  $osrelease = split($::operatingsystemrelease, '[.]')
  $osmajor = $osrelease[0]

  case $osmajor {
    5: { class{'nfs::client::redhat5': } }
    6: { class{'nfs::client::redhat6': } }
    default: { fail("Unsupported redhat release: ${osmajor}") }
  }

  service {"nfslock":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => $osmajor ? {
      5 => [Package["portmap"], Package["nfs-utils"]],
      6 => Service["rpcbind"],
    },
  }
 
  service { "netfs":
    enable  => true,
    require => $osmajor ? {
      5 => [Service["portmap"], Service["nfslock"]],
      6 => Service["nfslock"],
    },
  }

}
