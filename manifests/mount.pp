# This defines an NFS mount point
define nfs::mount(
  $server,
  $share,
  $mountpoint,
  $ensure         = 'present',
  $server_options = undef,
  $client_options = 'auto',
) {

  # use exported resources
  @@nfs::export {"shared ${share} by ${server} for ${::fqdn} mounted on ${mountpoint}":
    ensure  => $ensure,
    share   => $share,
    options => $server_options,
    guest   => $::ipaddress,
    tag     => $server,
  }

  mount {"shared ${share} by ${server} mounted on ${mountpoint}":
    device   => "${server}:${share}",
    fstype   => 'nfs',
    name     => $mountpoint,
    options  => $client_options,
    remounts => false,
    atboot   => true,
  }

  case $ensure {
    'present': {
      exec {"create ${mountpoint} and parents":
        command => "mkdir -p ${mountpoint}",
        unless  => "test -d ${mountpoint}",
        path    => $::path,
      }
      Mount["shared ${share} by ${server} mounted on ${mountpoint}"] {
        require => [Exec["create ${mountpoint} and parents"], Class['nfs::client']],
        ensure  => mounted,
      }
    }

    'absent': {
      file { $mountpoint:
        ensure  => absent,
        require => Mount["shared ${share} by ${server} mounted on ${mountpoint}"],
      }
      Mount["shared ${share} by ${server} mounted on ${mountpoint}"] {
        ensure => unmounted,
      }
    }

    default: {
      fail('Ensure should be `present` or `absent`')
    }
  }

}
