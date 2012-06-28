define dhcp::subnet (
  $netmask     = false,
	$range_start = false,
	$range_end   = false,
  $router      = false,
	$domain_name = false,
	$dns_servers = false,
	$pxe_only    = false,
  $pxe_opts    = false
) inherits dhcp::params {
  include dhcp
  
  File {
    owner => 'root',
    group => 'root',
  }

	file {"${dhcp::params::dhcp_config_dir}/subnets/local.conf":
    ensure 	 => present,
    content  => template("dhcp/subnet_conf.erb"),
    requires => Class['dhcp::config'],
    notify   => Class['dhcp::service'],
  }
}

# TODO: use concatfilepart to add include line to dhcpd.conf rather than statically set path
#	common::concatfilepart {"dhcp.${name}":
#    	file => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
#    	ensure => $ensure,
#    	content => "include \"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf\";\n",
#  	}

#	file {"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf":

