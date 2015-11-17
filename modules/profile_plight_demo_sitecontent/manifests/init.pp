
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   class { 'profile_plight_demo_sitecontent': }
# }
class profile_plight_demo_sitecontent (
  $client_body_buffer_size        = undef,
) inherits ::profile_plight_demo_sitecontent::params {

  file { $docroot_stuff:
    ensure => 'directory',
    owner  => "${usrgrp}",
    group  => "${usrgrp}",
    mode   => '0755',
  } ->
  file { '/var/www/plight_demo/index.html':
    ensure  => file,
    content => template("${module_name}/conf.d/index.html.erb"),
    owner  => "${usrgrp}",
    group  => "${usrgrp}",
    mode   => '0755',
  } ->
  # copy a remote file to /etc/sudoers
  file { "/var/www/plight_demo/nginx.png":
    owner  => "${usrgrp}",
    group  => "${usrgrp}",
    mode   => '0755',
    source => "puppet:///modules/${module_name}/nginx.png"
  }
}
