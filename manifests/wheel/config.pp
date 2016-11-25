#
# [root@centos7 sites]# authconfig --test | grep "password hashing algorithm" | awk '{ print $NF }'
# md5
#
class pam::wheel::config inherits pam::wheel {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  # [root@centos7 ~]# grep whee /etc/pam.d/su | grep requi | sed 's/#\(auth[ \t]*required[ \t]*pam_wheel.so[ \t]*use_uid\)/\1/'
  # # Uncomment the following line to require a user to be in the "wheel" group.
  # auth required pam_wheel.so use_uid

  if($limit_su_to_wheel)
  {
    exec { 'limit su to wheel group':
      command => "sed 's/^#\\(auth[ \\t]*required[ \\t]*pam_wheel.so[ \\t]*use_uid.*\\)$/\\1/' -i ${pam::params::pamd_su}",
      unless  => "grep -P \"^auth[ \t]*required[ \t]*pam_wheel.so[ \t]*use_uid\" ${pam::params::pamd_su}",
    }
  }
  else
  {
    exec { 'limit su to wheel group':
      command => "sed 's/^\\(auth[ \\t]*required[ \\t]*pam_wheel.so[ \\t]*use_uid.*\\)$/#\\1/' -i ${pam::params::pamd_su}",
      unless  => "grep -P \"^#auth[ \t]*required[ \t]*pam_wheel.so[ \t]*use_uid\" ${pam::params::pamd_su}",
    }
  }


}
