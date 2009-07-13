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
      exec {"create ${mountpoint}":
        command     => "mkdir -p ${mountpoint}",
        unless      => "test -d ${mountpoint}",
      }
      Mount[$share] {
        require     => Exec["create ${mountpoint}"],
        ensure      => mounted,
      }
    }

    absent: {
      exec {"remove ${mountpoint}":
        command     => "rmdir ${mountpoint}",
        onlyif      => "test -d ${mountpoint}",
        refreshonly => true,
      }
      Mount[$share] {
        notify      => Exec["remove ${mountpoint}"],
        ensure      => unmounted,
      }
    }
  }

}
