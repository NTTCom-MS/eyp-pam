# to be renamed
class pam::unix(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $password_hash_algo    = $pam::params::password_hash_algo_default,
                      $remember              = '5',
                    ) inherits pam::params{

  include ::pam

  Class['::pam'] ->
  class { '::pam::unix::install': } ->
  class { '::pam::unix::config': } ->
  Class['::pam::unix']

}
