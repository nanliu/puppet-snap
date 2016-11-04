# Class: snap::service
# ===========
class snap::service {
  service { 'snap-telemetry':
    ensure => $::snap::service_ensure,
    enable => $::snap::service_enable,
  }
}
