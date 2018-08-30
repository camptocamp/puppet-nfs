# Defines an NFS export
define nfs::export (
  $guest,
  $share,
  $ensure  = 'present',
  $options = undef,
) {

  $concatshare = regsubst($share, '/', '-', 'G')
  $concatguest = regsubst($guest, '/','-', 'G')

  if $options {
    $content = "${share}     ${guest}(${options})\n"
  } else {
    $content = "${share}     ${guest}\n"
  }

  Concat <| title == '/etc/exports' |>
  if $ensure == 'present' {
    concat::fragment {"${name}-${concatshare}-on-${concatguest}":
      content => $content,
      target  => '/etc/exports',
    }
  }

}
