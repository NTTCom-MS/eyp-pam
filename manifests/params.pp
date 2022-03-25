class pam::params {

  $limits_conf='/etc/security/limits.conf'

  $pamd_su = '/etc/pam.d/su'

  case $::osfamily
  {
    'redhat':
    {
      $pam_systemauth_system='/etc/pam.d/system-auth-ac'
      $pam_package_name='pam'
      $use_authconfig=true
      $use_pwhistory=false
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
        /^[78].*$/:
        {
          $password_hash_algo_default = 'sha512'
          $cracklib_package_name = 'libpwquality'
          $pwqualityconf = '/etc/security/pwquality.conf'
          $pamcracklib = false
          $pam_lockout = 'faillock'
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
      $use_pwhistory=true
      $pwhistory_pamd='/etc/pam.d/common-password'
      $password_hash_algo_default = 'sha512'
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[468].*$|^20.*$/:
            {
              $pam_lockout='tally2'

              $cracklib_package_name = 'libpam-pwquality'
              $pwqualityconf = '/etc/security/pwquality.conf'
              $pamcracklib = false

              # root@croscat:~# apt-file search pam_pwhistory.so
              # libpam-modules: /lib/x86_64-linux-gnu/security/pam_pwhistory.so

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
      #TODO:
      $use_authconfig=false
      $use_pwhistory=false
    }
    default: { fail('Unsupported OS!')  }
  }
}
