class pam::params {

  $limits_conf='/etc/security/limits.conf'

  case $::osfamily
  {
    'redhat':
    {
      $pam_package_name='pam'
      $use_authconfig=true
      case $::operatingsystemrelease
      {
        /^5.*$/:
        {
          # not sure
          $password_hash_algo_default = 'md5'
          $cracklib_package_name = undef
          $pwqualityconf = undef
          $pamcracklib = true
          $pam_lockout=''
        }
        /^6.*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = undef
          $pwqualityconf = undef
          $pamcracklib = true
          $pam_lockout='faillock'
          #
          $authconfig_systemauth_custom_file='/etc/pam.d/system-auth-local'
          $authconfig_systemauth_template="${module_name}/lockout/faillock/systemauth.erb"
          $authconfig_password_custom_file='/etc/pam.d/password-auth-local'
          $authconfig_password_template="${module_name}/lockout/faillock/password.erb"
          $real_password_auth_conf='/etc/pam.d/password-auth'
          $real_systema_auth_conf='/etc/pam.d/system-auth'
        }
        /^7.*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = 'libpwquality'
          $pwqualityconf = '/etc/security/pwquality.conf'
          $pamcracklib = false
          $pam_lockout='faillock'
          #
          $authconfig_systemauth_custom_file='/etc/pam.d/system-auth-local'
          $authconfig_systemauth_template="${module_name}/lockout/faillock/systemauth.erb"
          $authconfig_password_custom_file='/etc/pam.d/password-auth-local'
          $authconfig_password_template="${module_name}/lockout/faillock/password.erb"
          $real_password_auth_conf='/etc/pam.d/password-auth'
          $real_systema_auth_conf='/etc/pam.d/system-auth'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $pam_package_name='libpam-modules'
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
              $pam_lockout='tally2'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $pam_package_name='pam'
    }
    default: { fail('Unsupported OS!')  }
  }
}
