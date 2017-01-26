# Class: snap::config
# ===========
#
# Either deploys a default snapteld.conf, or dump the config_hash into YAML. User can specify a custom template via $::snap::template parameter.
#
class snap::config {
  if $::snap::config_hash {
    $config = $::snap::config_hash

    file { '/etc/snap/snapteld.conf':
      mode    => '0644',
      content => template($::snap::template),
    }
  } else {
    file { '/etc/snap/snapteld.conf':
      mode   => '0644',
      source => 'puppet:///modules/snap/snapteld.conf',
    }
  }
}
