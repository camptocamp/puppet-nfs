#
# == Class: nfs::server::redhat
#
# NFS server
# TODO: add NFS v4 support
#
class nfs::server::redhat inherits nfs::client::redhat {

  if Integer($::operatingsystemmajrelease) >= 7 {
    $servicename = 'nfs-server'
  } else {
    $servicename = 'nfs'
  }

  service{ 'nfs':
    ensure    => running,
    name      => $servicename,
    enable    => true,
    hasstatus => true,
    require   => Package[ 'nfs-utils' ],
  }

  @concat {'/etc/exports':
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Service['nfs'],
  }

}
