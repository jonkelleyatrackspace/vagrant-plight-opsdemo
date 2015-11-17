
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   class { 'profile_plight': }
# }
class profile_plight (
) inherits ::profile_plight::params {
  class { 'epel': }
  ->
  file { '/etc/yum.repos.d/plight.repo':
    owner  => "root",
    group  => "root",
    mode   => '0644',
    source => "puppet:///modules/${module_name}/plight.repo"
  }
  ->
  package { 'plight': ensure => 'installed' }
  ->
  exec { '/etc/init.d/plightd':
    command => '/etc/init.d/plightd start',
    path    => '/sbin:/bin:/usr/sbin:/usr/bin',
  }
}
