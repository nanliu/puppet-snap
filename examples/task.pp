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

snap::task { 'psutil-file.yaml':
  content =>  '---
  version: 1
  schedule:
    type: "simple"
    interval: "1s"
  max-failures: 10
  workflow:
    collect:
      metrics:
        /intel/psutil/cpu/cpu-total/user: {}
        /intel/psutil/cpu/cpu-total/system: {}
        /intel/psutil/cpu/cpu-total/idle: {}
        /intel/psutil/load/*: {}
      publish:
        - plugin_name: "file"
          config:
            file: "/tmp/psutil_metrics.log"',
}
