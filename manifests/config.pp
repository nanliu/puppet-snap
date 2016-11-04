# Class: snap::config
# ===========
#
# Either deploys a default snapd.conf, or dump the config_hash into YAML. User can specify a custom template via $::snap::template parameter.
#
class snap::config {
  if $::snap::config_hash {
    $config = $::snap::config_hash

    file { '/etc/snap/snapd.conf':
      mode    => '0644',
      content => template($::snap::template),
    }
  } else {
    file { '/etc/snap/snapd.conf':
      mode   => '0644',
      source => 'puppet:///modules/snap/snapd.conf',
    }
  }
}
