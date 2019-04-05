# == Class: pam
#
# === pam documentation
#
class pam(
          $manage_package         = true,
          $package_ensure         = 'installed',
          $manage_service         = true,
          $manage_docker_service  = true,
          $service_ensure         = 'running',
          $service_enable         = true,
          $manage_security_limits = true,
        ) inherits pam::params{

  class { '::pam::install': } ->
  class { '::pam::config': } ->
  Class['::pam']

}
