#
class pam::cracklib::config inherits pam::cracklib {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($pam::params::pwqualityconf!=undef)
  {
    file { $pam::params::pwqualityconf:
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/cracklib/pwquality.erb"),
    }
  }

  if($pam::params::pamcracklib)
  {
    # password    requisite     pam_cracklib.so try_first_pass retry=3 type=
    # password required pam_cracklib.so try_first_pass retry=3 minlen=14,dcredit=-1,ucredit=-1,ocredit=-1 lcredit=-1

    # file { '/tmp/exec_pam_cracklib':
    #   ensure  => 'present',
    #   content => template("${module_name}/exec_sedpamcracklib.erb"),
    # }
    #
    # file { '/tmp/exec_check_pam_cracklib':
    #   ensure  => 'present',
    #   content => template("${module_name}/exec_checkpamcracklib.erb"),
    # }
    exec { 'pam_cracklib setup':
      command => template("${module_name}/cracklib/exec_sedpamcracklib.erb"),
      unless  => template("${module_name}/cracklib/exec_checkpamcracklib.erb"),
    }
  }
}
