class nessus(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                            $manage_service        = true,
                            $manage_docker_service = true,
                            $service_ensure        = 'running',
                            $service_enable        = true,
                            $package_url           = undef,
                            $srcdir                = '/usr/local/src',
                          ) inherits nessus::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::nessus::install': }
  -> class { '::nessus::config': }
  ~> class { '::nessus::service': }
  -> Class['::nessus']

}
