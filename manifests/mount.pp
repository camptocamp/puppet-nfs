define nfs::mount(
  $server,
  $share,
  $mountpoint     = '',
  $ensure         = present,
  $server_options = '',
  $client_options = 'auto',
) {

  include nfs::client

  $real_mountpoint = $mountpoint? {
    ''      => $name,
    default => $mountpoint
  }

  validate_absolute_path($real_mountpoint)

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
    name        => $real_mountpoint,
    options     => $client_options,
    remounts    => false,
    atboot      => true,
  }

  case $ensure {
    present: {
      exec {"create ${real_mountpoint} and parents":
        command => "mkdir -p ${real_mountpoint}",
        unless  => "test -d ${real_mountpoint}",
      }
      Mount["shared ${share} by ${server}"] {
        require => [Exec["create ${real_mountpoint} and parents"], Class['nfs::client']],
        ensure  => mounted,
      }
    }

    absent: {
      file { $real_mountpoint:
        ensure  => absent,
        require => Mount["shared ${share} by ${server}"],
      }
      Mount["shared ${share} by ${server}"] {
        ensure => unmounted,
      }
    }
  }

}
