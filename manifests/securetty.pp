# puppet2sitepp @securettys
define pam::securetty (
                        $tty   = $name,
                        $order = '42',
                      ) {

  if(!defined(Concat['/etc/securetty']))
  {
    concat { '/etc/securetty':
      ensure => 'present',
      owner  => 'root',
      group  => 'root',
      mode   => '0600',
    }
  }

  if(!empty($tty))
  {
    concat::fragment { "securetty ${tty}":
      target  => '/etc/securetty',
      order   => $order,
      content => "${tty}\n",
    }
  }
}
