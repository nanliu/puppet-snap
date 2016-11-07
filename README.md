# Puppet Snap

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
  * [Custom Repo](#custom-repo)
  * [Binary Install](#binary-install)

## Overview

This module deploys [Snap](http://snap-telemetry.io/), an open source telemetry framework written in go.

## Module Description

This module deploys [Snap](https://github.com/intelsdi-x/snap) either via
packages, or precompiled binaries. The default apt/yum repository is
[packagecloud.io](https://packagecloud.io/intelsdi-x/snap), and the precompiled
binaries are retrieved from
[snap.ci.snap-telemetry.io](http://snap.ci.snap-telemetry.io/). The package
repo/binary url can be customized to suit your environment. Upgrades are only
supported when using software packages, and precompiled binaries are intended
for testing purposes only.

## Setup

This module depends on the [archive module](https://github.com/voxpupuli/puppet-archive) to fetch binaries.

## Usage

If you use heira, or use the default module config:
```puppet
include ::snap
```

### Custom Repo

Add any custom apt/yum repository and set `pkg_repo` parameter to `custom`.
```puppet
yumrepo { 'custom_snap':
  enabled  => 1,
  descr    => 'Custom snap repository',
  baseurl  => 'http://repos.acme.org/snap',
  gpgcheck => 1,
}

class { 'snap':
  pkg_repo = 'custom',
  require  => Yumrepo['custom_snap'],
}
```

### Binary Install

Disable `pkg_install`, and the version can be any release available on snap.ci.snap-telemetry.io:
```puppet
class { '::snap':
  version     => '0.17.0',
  pkg_install => false,
}
```

The parameter `pkg_url` will override the package download url, enabling this parameter will disregard the `version` setting.
```puppet
class { '::snap':
  pkg_install => false,
  pkg_url     => 'http://snap.ci.snap-telemetry.io/snap/latest_build/linux/x86_64',
}
```

NOTE: There's no upgrade support for binary installation, so 'latest' version only ensure it's 'latest' for the initial installation and not subsequent executions.

