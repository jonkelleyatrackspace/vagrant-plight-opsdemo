class profile_plight_demo_sitecontent::params {
  ### Operating System Configuration
  ## This is my hacky... no hiera system. Meh. :)

  # We use these
  $docroot_stuff = [ '/var/www/', '/var/www/plight_demo' ]

  # User and group setting
  $usrgrp = 'nginx'
}
