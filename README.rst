====================
NFS Puppet module
====================

This module is provided to you by Camptocamp_.

.. _Camptocamp: http://www.camptocamp.com/

------------
Dependencies
------------
You have to configure your puppetmaster so that exported ressources will work.

--------
Examples
--------
Client node ::

  node "my-nfs-client" {
    include nfs::client
    nfs::mount {"my mounted one":
      share       => '/srv/nfs/myshare',
      mountpoint  => '/mnt/nfs/myshare',
      ensure      => present,
      server      => "nfs.mydomain.ltd",
    }

    nfs::mount {"my unwanted one":
      share       => '/srv/nfs/myshare',
      mountpoint  => '/mnt/nfs/myshare',
      ensure      => absent,
      server      => "nfs.mydomain.ltd",
    }
  }

Server node ::
  node "my-nfs-server" {
    include nfs::server

    Nfs::Export <<| tag == "nfs.mydomain.ltd" |>>
  }


-------------
Documentation
-------------
http://reductivelabs.com/trac/puppet/wiki/ExportedResources
