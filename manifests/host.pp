define dhcp::host (
  $host=$name,
  $mac=false,
  $ip=false
) {
  include dhcp

	concat::fragment { $name:
    target	=> $dhcp::params::dhcp_hosts_conf,
    content	=> template('dhcp/hosts_conf.erb'),
    order	  => 02,
	}
}

