class { '::snap':
  version     => 'latest',
  pkg_install => false,
}

snap::plugin { 'snap-plugin-collector-psutil':
  version => 8,
}

snap::plugin { 'snap-plugin-publisher-file':
  version => 2,
}
