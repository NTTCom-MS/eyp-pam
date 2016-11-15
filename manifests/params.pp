class pam::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[56].*$/:
        {
          $cracklib_package_name = undef
          $pwqualityconf = undef
          $pamcracklib = true
        }
        /^[7].*$/:
        {
          $cracklib_package_name = 'libpwquality'
          $pwqualityconf = '/etc/security/pwquality.conf'
          $pamcracklib = false
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
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
