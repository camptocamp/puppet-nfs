define nfs::mount($ensure=present, 
                  $share, 
                  $mountpoint, 
                  $nfs_options, 
                  $rights, 
                  $srvrootdir, 
                  $server) {

  # use exported ressources
  @@nfs::export {"$share for $fqdn":
    ensure          => $ensure,
    srvrootdir      => $srvrootdir,
    share           => $share,
    options         => $nfs_options,
    rights          => $rights,
    guest           => $ipaddress,
  }

  mount {"$share":
    device      => "${server}:${srvrootdir}/${share}",
    fstype      => "nfs",
    name        => "${mountpoint}/${share}",
    options     => $rights,
    remounts    => false,
  }

  case $ensure {
    present: {
      exec {"create ${mountpoint}/${share}":
        command     => "mkdir -p ${mountpoint}/${share}",
        unless      => "test -d ${mountpoint}/${share}",
        require     => Package["nfs-common"],
      }
      exec {"mount $share on $mountpoint":
        command     => "mount -a",
        unless      => "mount | egrep -q \"^${server}:${srvrootdir}/${share} \"\" ",
      }
      Mount[$share] {
        require     => Exec["create ${mountpoint}/${share}"],
        ensure      => present,
        notify      => Exec["mount $share on $mountpoint"],
      }
    }

    absent: {
      exec {"remove ${mountpoint}/${share}":
        command     => "rmdir ${mountpoint}/${share}",
        onlyif      => "test -d ${mountpoint}/${share}",
      }
      Mount[$share] {
        notify      => Exec["remove ${mountpoint}/${share}"],
        ensure      => unmounted,
      }
    }
  }

}
