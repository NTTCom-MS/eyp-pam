class pam(
          $manage_package         = true,
          $package_ensure         = 'installed',
          $manage_security_limits = true,
        ) inherits pam::params{

  class { '::pam::install': } ->
  class { '::pam::config': } ->
  Class['::pam']

}
