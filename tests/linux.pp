include profiles
#profiles::linux {$::hostname :
#  pool           => 'dmz',
#  security_level => 'basic',
#  repo_base      => '0_REPO'
#}
class { 'profiles::linux' :
  security_level => 'basic',
}

