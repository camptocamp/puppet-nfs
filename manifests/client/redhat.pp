class nfs::client::redhat inherits nfs::base {

  package { "nfs-utils":
    ensure => present,
  }

  if versioncmp($::operatingsystemrelease, "6.0") > 0 {
    $osmajor = 6
  } elsif versioncmp($::operatingsystemrelease, "5.0") > 0 {
    $osmajor = 5
  }

  if $osmajor == 6 {
    package {"rpcbind":
      ensure => present,
    }

    service {"rpcbind":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package["rpcbind"], Package["nfs-utils"]],
    }

  } elsif $osmajor == 5 {

    package { "portmap":
      ensure => present,
    }    
    
    service { "portmap":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package["portmap"], Package["nfs-utils"]],
    }

  } else {
    fail("Unknown major Redhat release: ${::operatingsystemrelease}")
  }

  service {"nfslock":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => $osmajor ? {
      6 => Service["rpcbind"],
      5 => [Package["portmap"], Package["nfs-utils"]]
    },
  }
 
  service { "netfs":
    enable  => true,
    require => $osmajor ? {
      6 => Service["nfslock"],
      5 => [Service["portmap"], Service["nfslock"]],
    },
  }

}
