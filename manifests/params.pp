class check_mk::params{
  $workspace = '/root/check_mk'
  $agent_user = 'root'
  $agent_port = '6556'
  $xinetd_package_name = 'xinetd'
  $xinetd_service_name = 'xinetd'
  
  
  case $::osfamily {
    'Debian': {
      $agent_package_name = "check-mk-agent"
      $package_extension = ".deb"
      $package_provider = "aptitude"
    }
    'RedHat': {
      $agent_package_name = "check_mk-agent"
      $package_extension = ".noarch.rpm"
      $package_provider = "yum"
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}