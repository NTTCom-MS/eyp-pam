define pam::limit ( $item, $value, $domain=$name, $type='-' ) {

  #
  concat::fragment{ "limits.conf ${domain} ${name} ${type} ${item} ${value}":
    target  => $pam::params::limits_conf,
    order   => '01',
    content => template("${module_name}/limits/limit.erb"),
  }
}
