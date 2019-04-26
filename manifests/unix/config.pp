#
# [root@centos7 sites]# authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }'
# md5
#
class pam::unix::config inherits pam::unix {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($pam::params::use_authconfig)
  {
    #sed 's/^\(password[ \t]*sufficient[ \t]*pam_unix.so.*\)/\1 remember=5/'
    exec { 'red wedding':
      command => "sed 's/^\\(password[ \\t]*sufficient[ \\t]*pam_unix.so.*\\)$/\\1 remember=${pam::unix::remember}/' -i ${pam::params::pam_systemauth_system}",
      unless  => "grep -P \"^password[ \\t]*sufficient[ \\t]*pam_unix.so.*\" ${pam::params::pam_systemauth_system} | grep remember",
    }

    exec { 'the north remembers':
      command => "sed 's/^\\(password[ \\t]*sufficient[ \\t]*pam_unix.so.*[ \\t]remember=\\)[0-9]*\\(.*\\)$/\\1${pam::unix::remember}\\2/' -i ${pam::params::pam_systemauth_system}",
      unless  => "grep -P \"^password[ \\t]*sufficient[ \\t]*pam_unix.so.*[ \\t]remember=${pam::unix::remember}.*$\" ${pam::params::pam_systemauth_system}",
      require => Exec['red wedding'],
    }

    #authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }' | grep
    exec { 'set pam unix algo':
      command => "authconfig --passalgo=${pam::unix::password_hash_algo} --update",
      unless  => "authconfig --test | grep \"password hashing algorithm\" | awk '{ print \$NF }' | grep ${pam::unix::password_hash_algo}",
    }
  }
  else
  {
    if($pam::params::use_pwhistory)
    {
      # sudo touch /etc/security/opasswd
      # sudo chmod 600 /etc/security/opasswd
      file { '/etc/security/opasswd':
        ensure => 'present',
        owner  => 'root',
        group  => 'root',
        mode   => '0600',
      }

      exec { 'red wedding':
        command => "sed 's/\\(.*pam_unix.so.*\\)/password        required                        pam_pwhistory.so  remember=${pam::unix::remember}\\n\\1/g' -i ${pam::params::pwhistory_pamd}",
        unless  => "grep -E 'password.*required.*pam_pwhistory.so' ${pam::params::pwhistory_pamd}",
        require => File['/etc/security/opasswd'],
      }

      exec { 'the north remembers':
        command => "sed 's/\\(password[ ]*required[ ]*pam_pwhistory.so[ ]*remember=\\)[0-9]*/\\1${pam::unix::remember}/g' -i ${pam::params::pwhistory_pamd}",
        unless  => "grep -E 'password[ ]*required[ ]*pam_pwhistory.so[ ]*remember=${pam::unix::remember}\\b' ${pam::params::pwhistory_pamd}",
        require => Exec['red wedding'],
      }

      # TODO: ${pam::unix::password_hash_algo}
      # RHEL7      pam_unix.so  use_authtok try_first_pass nullok sha512 shadow
      # Ubuntu 16: pam_unix.so  use_authtok try_first_pass sha512 obscure

      # nullok
      #     The default action of this module is to not permit the user access to a service if their official password is blank. The nullok argument overrides this default and allows any user with a blank
      #     password to access the service.
      #
      # shadow
      #     Try to maintain a shadow based system.
      #
      # obscure
      #     Enable some extra checks on password strength. These checks are based on the "obscure" checks in the original shadow package. The behavior is similar to the pam_cracklib module, but for
      #     non-dictionary-based checks. The following checks are implemented:
      #
      #     Palindrome
      #         Verifies that the new password is not a palindrome of (i.e., the reverse of) the previous one.
      #
      #     Case Change Only
      #         Verifies that the new password isn't the same as the old one with a change of case.
      #
      #     Similar
      #         Verifies that the new password isn't too much like the previous one.
      #
      #     Simple
      #         Is the new password too simple? This is based on the length of the password and the number of different types of characters (alpha, numeric, etc.) used.
      #
      #     Rotated
      #         Is the new password a rotated version of the old password? (E.g., "billy" and "illyb")

    }
    else
    {
      fail("UNIMPLEMENTED")
    }
  }

}
