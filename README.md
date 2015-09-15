NFS Puppet module
====================

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/camptocamp/nfs.svg)](https://forge.puppetlabs.com/camptocamp/nfs)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/camptocamp/nfs.svg)](https://forge.puppetlabs.com/camptocamp/nfs)
[![Build Status](https://img.shields.io/travis/camptocamp/puppet-nfs/master.svg)](https://travis-ci.org/camptocamp/puppet-nfs)
[![Puppet Forge Endorsement](https://img.shields.io/puppetforge/e/camptocamp/nfs.svg)](https://forge.puppetlabs.com/camptocamp/nfs)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-nfs.svg)](https://gemnasium.com/camptocamp/puppet-nfs)
[![By Camptocamp](https://img.shields.io/badge/by-camptocamp-fb7047.svg)](http://www.camptocamp.com)


Examples
--------

Client node ::

```puppet
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
```

Server node ::

```puppet
node "my-nfs-server" {
  include nfs::server

  Nfs::Export <<| tag == "nfs.mydomain.ltd" |>>
}
```

