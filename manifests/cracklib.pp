# to be renamed to something like password_quality
class pam::cracklib(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $minlen                = '14',
                      $dcredit               = '-1',
                      $ucredit               = '-1',
                      $ocredit               = '-1',
                      $lcredit               = '-1',
                    ) inherits pam::params{

  include ::pam

  Class['::pam'] ->
  class { '::pam::cracklib::install': } ->
  class { '::pam::cracklib::config': } ->
  Class['::pam::cracklib']

}
