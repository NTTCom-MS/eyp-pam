class pam::install inherits pam {

  if($pam::manage_package)
  {
    package { $pam::params::pam_package_name:
      ensure => $pam::package_ensure,
    }
  }

}
