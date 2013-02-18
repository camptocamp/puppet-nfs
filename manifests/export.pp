define nfs::export ($ensure=present,
                    $share,
                    $options="",
                    $guest) {

  $concatshare = regsubst($share, '/', '-')
  $concatguest = regsubst($guest, '/','-')
 
  if $options == "" {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}($options)\n"
  }
  
  $exports = "/etc/exports"

  concat::fragment{"${concatshare}-on-${concatguest}":
    ensure  => $ensure,
    content => $content,
    target  => $exports,
  }

}
