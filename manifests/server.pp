class nfs::server {
  include concat::setup
  case $operatingsystem {
    Debian,Ubuntu:  { include nfs::server::debian}
    RedHat,CentOS,scientific,oel:  { include nfs::server::redhat}
    default:        { notice "Unsupported operatingsystem ${operatingsystem}" }
  }

  concat {'/etc/exports':
    owner => root,
    group => root,
    mode => '0644',
    notify => Exec['reload_nfs_srv'],
  }

}
