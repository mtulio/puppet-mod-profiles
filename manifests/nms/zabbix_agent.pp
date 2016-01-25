# == Class: profiles Zabbix
class profiles::nms::zabbix_agent (
  $gb_zabbix_a_server = $profiles::params::gb_zabbix_a_server,
) inherits profiles::params {
  #> Module: zabbix
  class {'::zabbix::agent':
    opt_use_template => 'yes',
    server           => $gb_zabbix_a_server,
    listen_ip        => $::ipaddress,
    listen_port      => '10050',
    start_agents     => '3',
  }
}
