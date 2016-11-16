class pam::params {

  $pam_package_name='pam'

  case $::osfamily
  {
    'redhat':
    {
      $use_authconfig=true
      case $::operatingsystemrelease
      {
        /^5.*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = undef
          $pwqualityconf = undef
          $pamcracklib = true
        }
        /^6.*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = undef
          $pwqualityconf = undef
          $pamcracklib = true
        }
        /^7.*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = 'libpwquality'
          $pwqualityconf = '/etc/security/pwquality.conf'
          $pamcracklib = false
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $use_authconfig=false
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              fail('not implemented')
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
