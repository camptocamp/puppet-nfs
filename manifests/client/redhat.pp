class nfs::client::redhat inherits nfs::base {

  package { 'nfs-utils':
    ensure => present,
  }

  if $::operatingsystemmajrelease == 6 {

    package {'rpcbind':
      ensure => present,
    }

    service {'rpcbind':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package['rpcbind'], Package['nfs-utils']],
    }

  } else {

    package { 'portmap':
      ensure => present,
    }

    service { 'portmap':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [Package['portmap'], Package['nfs-utils']],
    }

  }

  $nfslock_requirement = $::operatingsystemmajrelease ? {
    6       => Service['rpcbind'],
    default => [Package['portmap'], Package['nfs-utils']]
  }

  service {'nfslock':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => $nfslock_requirement,
  }

  $netfs_requirement = $::operatingsystemmajrelease ? {
    6       => Service['nfslock'],
    default => [Service['portmap'], Service['nfslock']],
  }

  service { 'netfs':
    enable  => true,
    require => $netfs_requirement,
  }

}
