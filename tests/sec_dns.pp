# Test: DNS
include profiles
class {'profiles::security::dns':
  server_type    => 'master',
  dnssec_enabled => 'yes',
}
