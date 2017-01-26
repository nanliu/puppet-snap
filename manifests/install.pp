class snap::install inherits ::snap::params {
  if $::snap::pkg_install {
    if $::snap::pkg_repo == 'packagecloud' {
      include ::snap::pkgcloud
      Class[::snap::pkgcloud] -> Package[$::snap::pkg_name]
    }

    package { $::snap::pkg_name:
      ensure => $::snap::version,
    }

    file { '/opt/snap/tasks':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package[$::snap::pkg_name],
    }
  }
  else {
    include ::snap::download
    Class[::snap::download] -> File['/usr/local/sbin/snapteld']
  }

  file { '/usr/local/sbin/snapteld':
    ensure => symlink,
    target => '/opt/snap/sbin/snapteld',
  }

  file { '/usr/local/bin/snaptel':
    ensure => symlink,
    target => '/opt/snap/bin/snaptel',
  }
}
