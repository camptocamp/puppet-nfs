class nfs::base {

  package { "portmap":
    ensure => present,
  }

  case $operatingsystem {

    Debian: {
      package { "nfs-common":
        ensure => present,
      }

      service { "nfs-common":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => Package["nfs-common"],
      }

      service { "portmap":
        ensure    => running,
        enable    => true,
        hasstatus => false,
        require   => Package["portmap"],
      }
    }

    RedHat: {
      package { "nfs-utils":
        ensure => present,
      }

      service { "netfs":
        enable  => true,
        require => [Service["portmap"], Service["nfslock"]],
      }

      service { ["portmap", "nfslock"]:
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [Package["portmap"], Package["nfs-utils"]],
      }
    }

  }
}
