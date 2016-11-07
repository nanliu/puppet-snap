# NOTE: the pkg_url overrides the version parameter.
class { '::snap':
  pkg_install => false,
  pkg_url     => 'http://snap.ci.snap-telemetry.io/snap/latest_build/linux/x86_64',
}
