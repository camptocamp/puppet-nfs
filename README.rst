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
    include nfs::base
    nfs::mount {"my mounted one":
      share       => 'myshare',
      mountpoint  => '/mnt/nfs',
      srvrootdir  => '/srv/nfs',
      ensure      => present,
    }

    nfs::mount {"my unwanted one":
      share       => 'myshare',
      mountpoint  => '/mnt/nfs',
      srvrootdir  => '/srv/nfs',
      ensure      => absent,
    }
  }

Server node ::
  node "my-nfs-server" {
    include nfs::server

    Nfs::Export <<| |>>
  }


-------------
Documentation
-------------
http://reductivelabs.com/trac/puppet/wiki/ExportedResources
