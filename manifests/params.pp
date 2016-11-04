# Class: snap::params
# ===========
class snap::params {
  $ci_url      = 'https://s3-us-west-2.amazonaws.com/snap.ci.snap-telemetry.io'
  $plugin_url  = "${ci_url}/plugins/"

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        5,6: {
          $svc_file = '/etc/rc.d/init.d/snap-telemetry'
          $svc_type = 'initd'
        }
        7: {
          $svc_file = '/usr/lib/systemd/system/snap-telemetry.service'
          $svc_type = 'systemd'
        }
        default: { fail("Unsupported RedHat version: ${::operatingsystemmajrelease}") }
      }
    }
    'Debian': {
      case $::operatingsystemmajrelease {
        14.04: {
          $svc_file = '/etc/rc.d/init.d/snap-telemetry'
          $svc_type = 'initd'
        }
        16.04: {
          $svc_file = '/lib/systemd/system/snap-telemetry.service'
          $svc_type = 'systemd'
        }
        default: { fail("Unsupported Debian/Ubuntu version: ${::operatingsystemmajrelease}") }
      }
    }
    default: { fail("Unsupported osfamily ${::osfamily}") }
  }
}
