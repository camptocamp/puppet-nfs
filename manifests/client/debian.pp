class nfs::client::debian  {

  include nfs::params

  package { ['nfs-common', $nfs::params::portmap]:
    ensure => present,
  }

  service { 'nfs-common':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['nfs-common'],
  }

  service {$nfs::params::portmap:
    ensure    => running,
    enable    => true,
    hasstatus => false,
    require   => Package[$nfs::params::portmap],
  }

}
