# Define: snap::plugin
# ====================
#
# deploy snap plugin
#
define snap::plugin (
  $type     = undef,
  $version  = undef,
  $url      = undef,
  $refresh  = false,
) {
  include ::snap::params

  if $url {
    $plugin_url = "${url}/${name}"
  } else {
    $plugin_url = "${::snap::params::ci_url}/plugins/${name}/${version}/linux/x86_64/${name}"
  }

  $plugin_path = "/opt/snap/plugins/${name}"

  archive { $plugin_path:
    ensure  => present,
    extract => false,
    source  => $plugin_url,
  }

  file { $plugin_path:
    mode    => '0755',
    require => Archive[$plugin_path],
  }

  if $refresh {
    Archive[$plugin_path] ~> Service['snap-telemetry']
  } else {
    Service['snap-telemetry'] -> Archive[$plugin_path]

    exec { "/usr/local/bin/snapctl plugin load ${plugin_path}":
      refreshonly => true,
      logoutput   => on_failure,
      require     => Service['snap-telemetry'],
      subscribe   => Archive[$plugin_path],
    }
  }
}
