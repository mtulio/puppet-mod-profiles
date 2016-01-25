# Test Linux class
include profiles
class { '::profiles::linux':
  security_level => 'basic',
  gb_repo_base   => '0_REPO',
  gb_pool        => 'dmz',
}
