define snap::task (
  $name,
  $content = undef,
  $source  = undef,
) {

  $task_path = "/opt/snap/tasks/${name}"

  file { $task_path:
    ensure  => present,
    content => $content,
    source  => $content,
  }
}
