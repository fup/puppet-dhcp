class dhcp {
	anchor { 'dhcp::begin': }
  -> class { 'dhcp::package': }
  -> class { 'dhcp::config': }
  ~> class { 'dhcp::service': }
  -> anchor { 'dhcp::end': }
}

