#
# == Class: nfs::server
#
# Define an NFS server
#
class nfs::server(
  $service_enable  = true,
  $service_running = true,
) {
  case $::operatingsystem {
    'Ubuntu':            { include ::nfs::server::ubuntu}
    'Debian':            { include ::nfs::server::debian}
    /^(RedHat|CentOS)$/: { include ::nfs::server::redhat }
    default:        { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }

  concat {'/etc/exports':
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service['nfs'],
  }

  concat::fragment {'etc-export-header':
    ensure  => present,
    order   => '00',
    content => '# File managed by Puppet',
    target  => '/etc/exports',
  }

}
