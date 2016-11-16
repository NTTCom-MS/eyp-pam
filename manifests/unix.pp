class pam::unix(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                      $password_hash_algo    = $password_hash_algo_default,
                    ) inherits pam::params{

  include ::pam

  Class['::pam'] ->
  class { '::pam::unix::install': } ->
  class { '::pam::unix::config': } ->
  Class['::pam::unix']

}
