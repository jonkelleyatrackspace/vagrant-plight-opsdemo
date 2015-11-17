stage { pre: before => Stage[main] }
stage { post: require => Stage[main] }

node 'nginx-n01','nginx-n02' {
	# Configure NGINX
	class { 'nginx': }
	nginx::resource::vhost { "${::fqdn}":
		ensure   => present,
		www_root => '/var/www/plight_demo',
		ssl      => false,
	}
	->
	class { 'profile_plight_demo_sitecontent' : } # demo site
	->
	class { 'profile_plight': } # configure plight
}

node 'loadbalancer' {
	class { 'profile_rsyslog': } # configure haproxy log facility
	->
	class { 'haproxy': 
		global_options   => { 'log'    => "127.0.0.1 local2", },
		defaults_options => { 'log'    => 'global',
							  'mode'   => 'http',
							  'option' => ['httplog', 
							  			   'log-health-checks',
							  			   'dontlognull',
							  			   'http-server-close'
							  			   ],
							  'timeout check'           => '10s',
							  'timeout http-keep-alive' => '10s',
							  'timeout server'          => '1m',
							  'timeout client'          => '1m',
							  'timeout connect'         => '10s',
							  'retries'                 => '3',
							  'timeout http-request'    => '10s',
							  'timeout queue'           => '1m'
							  },
	} 
	haproxy::frontend { 'main':
	  ipaddress     => $::ipaddress_eth1,
	  ports         => '5000',
	  mode          => 'http',
	  options       => { 'default_backend' => 'app', },
	} 
	haproxy::backend { 'app':
		options => {
			'option'     => 'httpchk GET / HTTP/1.1',
			'http-check' => 'disable-on-404',
			'balance'    => 'roundrobin',
	 		'server'     => ['nginx-n01.localdomain 10.10.10.12:80 check port 10101',
	    				  	 'nginx-n02.localdomain 10.10.10.13:80 check port 10101'
	    				  	 ]
		}
	}
}