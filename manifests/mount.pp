define nfs::mount(
  $server,
  $share,
  $mountpoint,
  $ensure=present,
  $server_options='',
  $client_options='auto',
) {

  # use exported ressources
  @@nfs::export {"shared ${share} by ${server} for ${::fqdn}":
    ensure          => $ensure,
    share           => $share,
    options         => $server_options,
    guest           => $::ipaddress,
    tag             => $server,
  }

  mount {"shared ${share} by ${server}":
    device      => "${server}:${share}",
    fstype      => 'nfs',
    name        => $mountpoint,
    options     => $client_options,
    remounts    => false,
    atboot      => true,
  }

  case $ensure {
    present: {
      file {"create ${mountpoint} and parents":
        ensure => directory,
        recurse => true,
        path   => "${mountpoint}",
      }
      Mount["shared ${share} by ${server}"] {
        require => [File["create ${mountpoint} and parents"], Class['nfs::client']],
        ensure  => mounted,
      }
    }

    absent: {
      file { $mountpoint:
        ensure  => absent,
        require => Mount["shared ${share} by ${server}"],
      }
      Mount["shared ${share} by ${server}"] {
        ensure => unmounted,
      }
    }
  }

}
