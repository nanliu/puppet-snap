class { '::snap':
  version     => 'latest',
  pkg_install => false,
}

# NOTE: this will attempt to load the plugin via `snap plugin load`
snap::plugin { 'snap-plugin-publisher-file':
  version => 2,
}

# NOTE: this will attempt to load the plugin by restarting the service
snap::plugin { 'snap-plugin-collector-psutil':
  version => 8,
  refresh => true,
}
