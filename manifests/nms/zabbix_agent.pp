# == Class: profiles Zabbix
class profiles::nms::zabbix_agent inherits profiles {
  #> Module: zabbix
  class {'::zabbix::agent':
    opt_use_template => 'yes',
    server           => 'zabbix.local',
    listen_ip        => $::ipaddress,
    listen_port      => '10050',
    start_agents     => '2',
  }
}
