define nfs::export ($ensure=present,
                    $share,
                    $options="",
                    $guest) {

  $concatshare = regsubst($share, '/', '-', 'G')
  $concatguest = regsubst($guest, '/', '-', 'G')
 
  if $options == "" {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}($options)\n"
  }
  
  $exports = "/etc/exports"

  concat {$exports:
    owner => root,
    group => root,
    mode  => 644,
    notify  => Exec['reload_nfs_srv'],
  }

  concat::fragment{"${concatshare}-on-${concatguest}":
    ensure  => $ensure,
    content => $content,
    target  => '/etc/exports',
  }

}
