define snap::task (
  $content = undef,
  $source  = undef,
  $refresh = false,
) {

  $task_path = "/opt/snap/tasks/${name}"

  file { $task_path:
    ensure  => present,
    content => $content,
    source  => $source,
  }

  if $refresh {
    File[$task_path] ~> Service['snap-telemetry']
  } else {
    Service['snap-telemetry'] -> File[$task_path]
    exec { "/usr/local/bin/snapctl task create -t ${task_path}":
      refreshonly => true,
      logoutput   => on_failure,
      require     => Service['snap-telemetry'],
      subscribe   => File[$task_path],
    }
  }
}
