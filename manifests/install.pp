class snap::install inherits ::snap::params {
  if $::snap::pkg_install {
    if $::snap::pkg_repo == 'packagecloud.io' {
      include ::snap::pkgcloud
      Class[::snap::pkgcloud] -> Package[$::snap_pkg_name]
    }

    package { $::snap::pkg_name:
      ensure => $::snap::version,
    }
  }
  else {
    include ::snap::download
    Class[::snap::download] -> File['/usr/local/bin/snapd']
  }

  file { '/usr/local/bin/snapd':
    ensure => symlink,
    target => '/opt/snap/bin/snapd',
  }

  file { '/usr/local/bin/snapctl':
    ensure => symlink,
    target => '/opt/snap/bin/snapctl',
  }
}
