class pam::lockout::install inherits pam::lockout {

  case $pam::params::pam_lockout
  {
    'faillock':
    {

    }
    default:
    {
      fail("${pam::params::pam_lockout} currently not implemented")
    }
  }

}
