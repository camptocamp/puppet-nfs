define nfs::mount($ensure=present,
                  $server,
                  $share,
                  $mountpoint,
                  $server_options=undef,
                  $server_rights=undef,
                  $client_options="auto") {

  # use exported ressources
  @@nfs::export {"$share for $fqdn":
    ensure          => $ensure,
    share           => $share,
    options         => $server_options,
    rights          => $server_rights,
    guest           => $ipaddress,
    tag             => $server,
  }

  mount {"$share":
    device      => "${server}:${share}",
    fstype      => "nfs",
    name        => "${mountpoint}",
    options     => $client_options,
    remounts    => false,
    atboot      => true,
  }

  case $ensure {
    present: {
      exec {"create ${mountpoint} and parents":
        command => "mkdir -p ${mountpoint}",
        unless  => "test -d ${mountpoint}",
      }
      Mount[$share] {
        require => Exec["create ${mountpoint} and parents"],
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
