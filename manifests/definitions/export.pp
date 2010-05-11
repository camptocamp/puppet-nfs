define nfs::export ($ensure=present,
                    $share,
                    $options="",
                    $guest) {

  $concatshare = substitute($share, '/', '-')
  $concatguest = substitute($guest, '/','-')
 
  if $options == "" {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}($options)\n"
  }
  
  common::concatfilepart {"${concatshare}-on-${concatguest}":
    ensure      => $ensure,
    content     => $content,
    file        => "/etc/exports",
    notify      => Exec['reload_nfs_srv'],
  }
}
