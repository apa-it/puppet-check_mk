class check_mk::agent::service (
  $xinetd_service_name = $::check_mk::params::xinetd_service_name
) inherits ::check_mk::params {
  if ! defined(Service[$xinetd_service_name]) {
    service { $xinetd_service_name:
      ensure => 'running',
      enable => true,
    }
  }
}
