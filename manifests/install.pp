# == Class: pam
#
# === pam::install documentation
#
class pam::install inherits pam {

  if($pam::manage_package)
  {
    package { $pam::params::package_name:
      ensure => $pam::package_ensure,
    }
  }

}
