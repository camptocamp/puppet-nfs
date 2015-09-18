# Class nfs::exports
# implements export resource
# it should work even if empty but if you want to put exports here then do the following
# Class{ nfs::exports:
#           export1    => {
#               $guest => "xyz.example.com",
#               $share => "/nfs/share/",
#               $options = "rootsquash,rw",
#
#            },
#         export2 => {}
#       }
class nfs::exports($exporthash = {})
{
    create_resources(::nfs::export, $exporthash)
}
