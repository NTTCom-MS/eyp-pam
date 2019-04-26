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

      #TODO: ${pam::unix::password_hash_algo}

    }
    else
    {
      fail("UNIMPLEMENTED")
    }
  }

}
