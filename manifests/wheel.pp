class pam::wheel(
                  $limit_su_to_wheel = true,
                ) inherits pam::params{

  include ::pam

  Class['::pam'] ->
  class { '::pam::wheel::install': } ->
  class { '::pam::wheel::config': } ->
  Class['::pam::wheel']

}
