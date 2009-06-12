define nfs::export ($ensure=present,
                    $share,
                    $rights,
                    $options,
                    $guest) {

  $concatshare = substitute($share, '/', '-')
  $concatguest = substitute($guest, '/','-')
  
  common::concatfilepart {"${concatshare}-on-${concatguest}":
    ensure      => $ensure,
    content     => "${share}     ${guest}(${rights},${options})\n",
    file        => "/etc/exports",
    notify      => Exec['reload_nfs_srv'],
  }
}
