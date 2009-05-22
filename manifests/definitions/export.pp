define nfs::export ($ensure=present,
                    $srvrootdir,
                    $share,
                    $rights,
                    $options,
                    $guest) {

  $concatpart = substitute($share, '/', '-')
  
  common::concatfilepart {"${concatpart}-on-${guest}":
    ensure      => $ensure,
    content     => "${srvrootdir}/${share}     ${guest}(${rights},${options})\n",
    file        => "/etc/exports",
    notify      => Exec['reload_nfs_srv'],
  }
}
