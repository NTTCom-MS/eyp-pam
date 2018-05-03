# puppet2sitepp @securettys
# @param tty tty name (default: resource's name)
# @param order securetty order (default: 42)
define pam::securetty (
                        $tty    = $name,
                        $order  = '42',
                        $ensure = 'present',
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

  case $ensure
  {
    'present':
    {
      if(!empty($tty))
      {
        concat::fragment { "securetty ${tty}":
          target  => '/etc/securetty',
          order   => $order,
          content => "${tty}\n",
        }
      }
    }
    default: {}
  }


}
