class dhcp::params {
	case $::operatingsystem {
	  default: { 
	    $config_dir   = '/etc/dhcp' 
	    $packages     = ['dhcpd']
	    $service_name = 'dhcpd'
	  }
	}
	
	$hosts_config_dir		= "${dhcp_config_dir}/hosts"
	$hosts_conf			    = "${dhcp_config_dir}/hosts.conf"
}
