class nfs::client::redhat inherits nfs::base {

    package { "nfs-utils":
       ensure => present,
    }


    package {"rpcbind":
      ensure => present,
    }

    service {"rpcbind":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package["rpcbind"], Package["nfs-utils"]],
    }


    service {"nfslock":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => Service["rpcbind"],
    }
 
    service { "netfs":
      enable  => true,
      require => Service["nfslock"],
    }

}
