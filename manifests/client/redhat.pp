# Specific settings for client on Redhat distribution.
class nfs::client::redhat inherits nfs::base {

  package { 'nfs-utils':
    ensure => present,
  }

  case $::operatingsystemmajrelease {
    '5': {
      $service = 'portmap'
      $nfslock = true
      $netfs = true
    }
    '6': {
      $service = 'rpcbind'
      $nfslock = true
      $netfs = true
    }
    '7': {
      $service = 'rpcbind'
      $nfslock = false
      $netfs = false
    }
    default: { fail('This version of Red Hat is not supported!') }
  }

  package {$service:
    ensure => present,
  }

  service {$service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => [Package[$service], Package['nfs-utils']],
  }

  if ($nfslock) {
    $nfslock_requirement = $::operatingsystemmajrelease ? {
      '6'     => Service['rpcbind'],
      default => [Package['portmap'], Package['nfs-utils']]
    }

    service {'nfslock':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => $nfslock_requirement,
    }
  }

  if ($netfs) {
    $netfs_requirement = $::operatingsystemmajrelease ? {
      '6'     => Service['nfslock'],
      default => [Service['portmap'], Service['nfslock']],
    }

    service { 'netfs':
      enable  => true,
      require => $netfs_requirement,
    }
  }

}
