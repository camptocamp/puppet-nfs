define nfs::export (
  $guest,
  $share,
  $ensure=present,
  $options='',
) {

  $concatshare = regsubst($share, '/', '-', 'G')
  $concatguest = regsubst($guest, '/','-', 'G')

  if $options == '' {
    $content = "${share}     ${guest}\n"
  } else {
    $content = "${share}     ${guest}($options)\n"
  }

  Concat <| title == '/etc/exports' |>

  concat::fragment {"${name}-${concatshare}-on-${concatguest}":
    ensure  => $ensure,
    content => $content,
    target  => '/etc/exports',
  }

}
