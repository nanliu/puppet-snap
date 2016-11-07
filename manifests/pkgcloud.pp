class snap::pkgcloud {
  case $::osfamily {
    # TODO: finish pkg cloud repo
    'Debian': {
      ensure_packages('apt-transport-https')

      include ::apt

      apt::source { 'intelsdi-x':
        location => 'https://packagecloud.io/intelsdi-x/snap/ubuntu/',
        repos    => 'main',
        key      => {
          'id'   => '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB',
        },
      }

      Exec['apt_update'] -> Package[$::snap::pkg_name]
    }
    'RedHat': {
      yumrepo { 'instelsdi-x':
        ensure        => 'present',
        baseurl       => 'https://packagecloud.io/intelsdi-x/snap/el/$releasever/$basearch',
        repo_gpgcheck => 1,
        gpgkey        => 'https://packagecloud.io/intelsdi-x/snap/gpgkey',
        gpgcheck      => 0,
        sslverify     => 1,
        sslcacert     => '/etc/pki/tls/certs/ca-bundle.crt',
      }
    }
    default: {
      fail("${::osfamily} not supported for snap.")
    }
  }
}
