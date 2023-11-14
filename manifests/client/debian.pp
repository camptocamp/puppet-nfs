# Specific settings for client on Debian distribution.
class nfs::client::debian {
  include nfs::params

  [
    'nfs-common',
    $nfs::params::portmap_package,
  ].each |String[1] $pkg| {
    package { $pkg:
      ensure => installed,
    }
  }

  service { $nfs::params::statd_service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['nfs-common'],
  }

  service { $nfs::params::portmap_service:
    ensure    => running,
    enable    => $nfs::params::portmap_enable,
    hasstatus => false,
    require   => Package[$nfs::params::portmap_package],
  }
}
