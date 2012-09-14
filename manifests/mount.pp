define nfs::mount($ensure=present,
                  $share,
                  $mountpoint,
                  $server,
                  $server_options='',
                  $client_options='auto') {

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
      exec {"create ${mountpoint} and parents":
        command => "/bin/mkdir -p ${mountpoint}",
        unless  => "/usr/bin/test -d ${mountpoint}",
      }
      Mount["shared ${share} by ${server}"] {
        require => [Exec["create ${mountpoint} and parents"], Class['nfs::client']],
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
