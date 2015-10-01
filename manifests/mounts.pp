class nfs::mounts($mounthash = {}){
  create_resources(::nfs::mount,$mounthash)
}

