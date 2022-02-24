class nessus::service inherits nessus {

  #
  validate_bool($nessus::manage_docker_service)
  validate_bool($nessus::manage_service)
  validate_bool($nessus::service_enable)

  validate_re($nessus::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${nessus::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $nessus::manage_docker_service)
  {
    if($nessus::manage_service)
    {
      service { $nessus::params::service_name:
        ensure     => $nessus::service_ensure,
        enable     => $nessus::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}
