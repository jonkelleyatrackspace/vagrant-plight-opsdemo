 
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   class { 'profile_rsyslog': }
# }
class profile_rsyslog (
) inherits ::profile_rsyslog::params {
  class { 'rsyslog::server':
    enable_tcp                => true,
    enable_udp                => true,
    port                      => '514',
    enable_relp               => false,
    server_dir                => '/srv/log/',
    address                   => '*',
    custom_config       => 'profile_rsyslog/haproxy.erb'
  } -> 
  rsyslog::imfile { 'haproxy':
    file_name     => 'haproxy.log',
    file_tag      => '*',
    file_facility => 'local2',
    file_severity => 'info',
  }
}
