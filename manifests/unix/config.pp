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
    #authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }' | grep
    exec { 'set pam unix algo':
      command => "authconfig --passalgo=${pam::unix::password_hash_algo} --update",
      unless  => "authconfig --test | grep \"password hashing algorithm\" | awk '{ print $NF }' | grep ${pam::unix::password_hash_algo}",
    }
  }
  else
  {
    fail('not implemented')
  }
}
