# == Class: pam
#
# === pam::install documentation
#
class pam::unix::install inherits pam::unix {

  # if($pam::unix::manage_package)
  # {
  #   package { $pam::params::pam_package_name:
  #     ensure => $pam::package_ensure,
  #   }
  # }
  if(!$pam::params::use_authconfig)
  {
    fail('feature not available')
  }

}
