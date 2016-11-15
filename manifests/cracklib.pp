#
class pam::cracklib(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                      $minlen                = '14',
                      $dcredit               = '-1',
                      $ucredit               = '-1',
                      $ocredit               = '-1',
                      $lcredit               = '-1',
                    ) inherits pam::params{

  class { '::pam::cracklib::install': } ->
  class { '::pam::cracklib::config': } ->
  Class['::pam::cracklib']

}
