class nfs::client::debian inherits nfs::base {

  case $operatingsystem {
    Debian: {
      case $lsbdistcodename {
        squeeze:  {
          $rpcbind_service_name = "portmap"
          $rpcbind_package_name = "portmap" 
        }
        default:  {
          $rpcbind_service_name = "rpcbind"
          $rpcbind_package_name = "rpcbind" 
        }
      }
    default:  {
      $rpcbind_service_name = "portmap"
      $rpcbind_package_name = "portmap" 
    }
  }
  
  package { ["nfs-common", "$rpcbind_package_name"]:
    ensure => present,
  }
 
  service { "nfs-common":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package["nfs-common"],
  }
 
  service { "$rpcbind_service_name":
    ensure    => running,
    enable    => true,
    hasstatus => false,
    require   => Package["$rpcbind_package_name"],
  }

}
