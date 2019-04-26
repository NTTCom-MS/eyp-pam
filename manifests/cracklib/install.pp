class pam::cracklib::install inherits pam::cracklib {

  if($pam::cracklib::manage_package)
  {
    if($pam::params::cracklib_package_name!=undef)
    {
      package { $pam::params::cracklib_package_name:
        ensure => $pam::cracklib::package_ensure,
      }
    }
  }
}
