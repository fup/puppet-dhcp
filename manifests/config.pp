class dhcp::config {
  include concat::setup
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  Concat {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  file { [ $dhcp::params::config_dir, "${dhcp::params::config_dir}/subnets", 
           $dhcp::parmas::hosts_config_dir]:
    ensure  => directory,
    recurse => true,
    purge   => true, 
  }
  file { '/etc/dhcpd.conf':
    ensure  => present,
    content => template('dhcp/dhcpd.conf.erb'),
  }
  #  use concat::fragment to add include line to dhcpd.conf rather than statically set path
  concat {$dhcp::params::hosts_conf:
    require	=> File[$dhcp::parmas::hosts_config_dir],
  }
  concat::fragment { "dhcp-hosts-static-conf":
		target	=> $dhcp::params::hosts_conf,
		content	=> template('dhcp/hosts_static_conf.erb'),
		order	  => 01,
	}
	
	if $dhcp_hosts {
		# NOTE: You can use string2hash to send the dhcp_hosts parameter as a json formatted string
		# See https://github.com/treydock/puppet-string2hash
		# $hosts = string2hash($dhcp_hosts)
		create_resources('dhcp::host', $dhcp_hosts)
	}
}

# TODO: use concatfilepart to add include line to dhcpd.conf rather than statically set path
#	common::concatfilepart {"00.dhcp.server.base":
#    	file    => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
#    	ensure  => present,
#    	require => Package["dhcp"],
#    	notify  => Service["dhcpd"],
#  	}

