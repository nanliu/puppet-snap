# Class: snap
# ===========
#
# deploys [Snap](snap-telemetry.io) via packages or binaries, along with configs and enable snap-telemetry services.
#
# Parameters
# ----------
#
# version: for package installation, this corresponds with puppet package resource iensure parameter, i.e. package version, installed, latest. for binary installation, either snap version (0.17.0), latest, latest_build, or git sha1. (default: latest)
#
# pkg_install: whether to use snap package for software installation. (default: true)
#
# pkg_repo: use packagecloud.io repo or custom repo. (default: packagecloud)
#
# pkg_name: snap package name. this has changed due to conflicts with ubuntu packages. (default: snap-telemetry)
#
# pkg_url: http(s) url to download snap binary.
#
# plugin_url: http(s) url to download snap plugins
#
# service_ensure: the state of snap service
#
# service_enable: wether to enable snap service
#
# config_hash: snap configuration in a hash
#
# template: snap configuration file template
#
class snap (
  $version        = 'latest',         # 0.17.0, installed, latest
  $pkg_install    = true,             # by default use package installation
  $pkg_repo       = 'packagecloud',   # custom, packagecloud
  $pkg_name       = 'snap-telemetry',
  $pkg_url        = undef,
  $plugin_url     = $::snap::params::plugin_url,
  $service_ensure = 'running',
  $service_enable = true,
  $config_hash    = undef,
  $template       = 'snap/snap.conf.erb',
) inherits ::snap::params {

  include ::snap::install
  include ::snap::config
  include ::snap::service

  Class[::snap::install] -> Class[::snap::config] ~> Class[::snap::service]
}
