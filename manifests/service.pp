class pam::service inherits pam {

  #
  validate_bool($pam::manage_docker_service)
  validate_bool($pam::manage_service)
  validate_bool($pam::service_enable)

  validate_re($pam::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${pam::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $pam::manage_docker_service)
  {
    if($pam::manage_service)
    {
      service { $pam::params::service_name:
        ensure => $pam::service_ensure,
        enable => $pam::service_enable,
      }
    }
  }
}
