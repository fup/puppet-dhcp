class dhcp::package {
  package { $dhcp::params::packages:
    ensure => present,
  }
}