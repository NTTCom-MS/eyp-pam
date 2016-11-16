# 4.1.2 - https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/chap-Hardening_Your_System_with_Tools_and_Services.html#sect-Security_Guide-Workstation_Security-Account_Locking
class pam::faillock(
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                    ) inherits pam::params{

  include ::pam

  Class['::pam'] ->
  class { '::pam::faillock::install': } ->
  class { '::pam::faillock::config': } ->
  Class['::pam::faillock']

}
