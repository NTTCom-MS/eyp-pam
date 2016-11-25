#
# [root@centos7 sites]# authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }'
# md5
#
class pam::unix::config inherits pam::unix {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  #sed 's/^\(password[ \t]*sufficient[ \t]*pam_unix.so.*\)/\1 remember=5/'
  exec { 'red wedding':
    command => "sed 's/^\\(password[ \\t]*sufficient[ \\t]*pam_unix.so.*\\)$/\\1 remember=${pam::unix::remember}/' -i ${pam::params::pam_systemauth_system}",
    unless  => "grep -P \"^password[ \\t]*sufficient[ \\t]*pam_unix.so.*\" ${pam::params::pam_systemauth_system} | grep remember",
  }

  exec { 'the north remembers':
    command => "sed 's/^\\(password[ \\t]*sufficient[ \\t]*pam_unix.so.*[ \\t]remember=\\)[0-9]*\\(.*\\)$/\\1${pam::unix::remember}\\2/' -i ${pam::params::pam_systemauth_system}",
    unless  => "grep -P \"^password[ \\t]*sufficient[ \\t]*pam_unix.so.*[ \\t]remember=${pam::unix::remember}.*$\" ${pam::params::pam_systemauth_system}",
  }

  if($pam::params::use_authconfig)
  {
    #authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }' | grep
    exec { 'set pam unix algo':
      command => "authconfig --passalgo=${pam::unix::password_hash_algo} --update",
      unless  => "authconfig --test | grep \"password hashing algorithm\" | awk '{ print \$NF }' | grep ${pam::unix::password_hash_algo}",
    }
  }
  else
  {
    fail('not implemented')
  }
}
