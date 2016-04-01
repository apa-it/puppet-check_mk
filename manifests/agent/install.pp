class check_mk::agent::install (
  $version           = "present",
  $filestore         = undef,
  $workspace         = undef,
  $package_name      = $::check_mk::params::agent_package_name,
  $package_extension = $::check_mk::params::package_extension,
  $package_provider  = $::check_mk::params::package_provider,
  $xinetd_package_name = $::check_mk::params::xinetd_package_name,
  
) inherits ::check_mk::params {
  if ! defined(Package[$xinetd_package_name]) {
    package { $xinetd_package_name:
      ensure => present,
    }
  }
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }
    file { "${workspace}/${package_name}-${version}${package_extension}":
      ensure  => present,
      source  => "${filestore}/${package_name}-${version}${package_extension}",
      require => Package[$xinetd_package_name],
    }

    package { "${package_name}":
      ensure   => present,
      provider => $package_provider,
      source   => "${workspace}/${package_name}-${version}${package_extension}",
      require  => File["${workspace}/${package_name}-${version}${package_extension}"],
    }

  }
  else {
    package { "${package_name}":
      ensure  => $version,
      require => Package[$xinetd_package_name],
    }
  }
}
