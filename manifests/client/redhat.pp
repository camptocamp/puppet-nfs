# Specific settings for client on Redhat distribution.
class nfs::client::redhat inherits nfs::base {
  case $facts['os']['release']['major'] {
    '8': {
      $nfslock_requirement = undef
      $nfslock_service     = 'rpc-statd'
      $nfsclient_service   = undef
      $nfsclient_package   = 'rpcbind'
      $netfs_requirement   = undef
    }
    default : {
      fail('This Major release is not supported')
    }
  }
  # common items for all versions
  $nfsclient_requirement  = [Package['nfs-client'], Package['nfs-utils']]
  package { 'nfs-utils':
    ensure => present,
  }

  service { 'nfslock':
    ensure    => running,
    name      => $nfslock_service,
    enable    => true,
    hasstatus => true,
    require   => $nfslock_requirement,
  }
  if  versioncmp($::operatingsystemmajrelease, '7')  < 0 {
    service { 'netfs':
      enable  => true,
      require => $netfs_requirement,
    }
  }
  package { 'nfs-client':
    ensure => present,
    name   => $nfsclient_package,
  }

  if $nfsclient_service {
    service {'nfs-client':
      ensure    => running,
      name      => $nfsclient_service,
      enable    => true,
      hasstatus => true,
      require   => $nfsclient_requirement,
    }
  }
}
