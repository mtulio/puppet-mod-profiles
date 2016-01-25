#
# == Class: SECURITY / DNSsec
#
class profiles::security::dns (
  $base_config      = undef,
  $server_type      = undef,
  $dnssec_enabled   = 'no',
) {

  if $base_config and $server_type {
    $use_file_config = 'yes'
    class { '::dnssec' :
      base_config  => $base_config,
      server_type  => $server_type,
      gb_dnssec_en => $dnssec_enabled,
    }
  } else {
    class { '::dnssec' : }
  }
}
