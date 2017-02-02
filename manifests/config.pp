# == Class: pam
#
# === pam::config documentation
#
class pam::config inherits pam {

  concat { $pam::params::limits_conf:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment{ 'limits.conf header':
    target  => $pam::params::limits_conf,
    order   => '00',
    content => template("${module_name}/limits/limits_header.erb"),
  }

}
