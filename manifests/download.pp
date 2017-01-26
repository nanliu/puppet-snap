#  Class: snap::download
#  =====================
#
#  download snap binaries, typically for testing ci builds.
#
class snap::download inherits snap::params {
  if $::snap::pkg_url {
    $pkg_url = $::snap::pkg_url
  } else {
    $pkg_url = "${::snap::params::ci_url}/snap/${::snap::version}/linux/x86_64"
  }

  # NOTE: we are doing a poor man's package simulation:
  $dir = [
    '/etc/snap',
    '/etc/snap/keyrings',
    '/opt/snap',
    '/opt/snap/bin',
    '/opt/snap/plugins',
    '/opt/snap/tasks',
    '/var/log/snap',
  ]

  file { $dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  $snapteld = '/opt/snap/sbin/snapteld'
  $snaptel = '/opt/snap/bin/snaptel'

  archive { $snapteld:
    ensure        => present,
    source        => "${pkg_url}/snapteld",
    checksum_type => 'none',
  }

  archive { $snaptel:
    ensure        => present,
    source        => "${pkg_url}/snaptel",
    checksum_type => 'none',
  }

  file { [ $snapteld, $snaptel ]:
    mode    => '0755',
    require => Archive[$snapteld, $snaptel],
  }

  file { $::snap::params::svc_file:
    ensure => present,
    mode   => '0644',
    source => "puppet:///modules/snap/service.${::operatingsystemmajrelease}",
  }

  if $::snap::params::svc_type == 'systemd' {
    exec { 'systemctl daemon-reload':
      path        => $::path,
      refreshonly => true,
      subscribe   => File[$::snap::params::svc_file],
    }
  }
}
