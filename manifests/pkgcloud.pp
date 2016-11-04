class snap::pkgcloud {
  case $::osfamily {
    # TODO: finish pkg cloud repo
    'Debian': {
      ensure_package('apt-transport-https')
    }
    'RedHat': {
    }
    default: {
      fail("${::osfamily} not supported for snap.")
    }
  }
}
