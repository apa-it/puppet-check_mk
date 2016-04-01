class check_mk::agent (
  $filestore    = undef,
  $host_tags    = undef,
  $ip_whitelist = undef,
  $port         = $::check_mk::params::agent_port,
  $server_dir   = '/usr/bin',
  $use_cache    = false,
  $user         = $::check_mk::params::agent_user,
  $version      = undef,
  $workspace    = $::check_mk::params::workspace,
) inherits ::check_mk::params {
  class { 'check_mk::agent::install':
    version   => $version,
    filestore => $filestore,
    workspace => $workspace,
  }
  class { 'check_mk::agent::config':
    ip_whitelist => $ip_whitelist,
    port         => $port,
    server_dir   => $server_dir,
    use_cache    => $use_cache,
    user         => $user,
    require      => Class['check_mk::agent::install'],
  }
  include check_mk::agent::service
  @@check_mk::host { $::fqdn:
    host_tags => $host_tags,
  }
}
