define nfs::mount($ensure=present,
                  $share,
                  $mountpoint,
                  $nfs_options,
                  $rights,
                  $server) {

  # use exported ressources
  @@nfs::export {"$share for $fqdn":
    ensure          => $ensure,
    share           => $share,
    options         => $nfs_options,
    rights          => $rights,
    guest           => $ipaddress,
    tag             => $server,
  }

  mount {"$share":
    device      => "${server}:${share}",
    fstype      => "nfs",
    name        => "${mountpoint}",
    options     => $rights,
    remounts    => false,
  }

  case $ensure {
    present: {
      exec {"create ${mountpoint} and parents":
        command => "mkdir -p ${mountpoint}",
        unless  => "test -d ${mountpoint}",
      }
      file { $mountpoint:
        ensure  => present,
        require => Exec["create ${mountpoint} and parents"],
      }
      Mount[$share] {
        require => File[$mountpoint],
        ensure  => mounted,
      }
    }

    absent: {
      file { $mountpoint:
        ensure  => absent,
        require => Mount[$share],
      }
      Mount[$share] {
        ensure => unmounted,
      }
    }
  }

}
