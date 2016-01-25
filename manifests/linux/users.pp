#
# == Class: profiles/linux/users
#
# This module manages users.
#
class profiles::linux::users {

  # Default configuration
  $default_gid    = 'infra'
  $default_ensure = 'present'
  $default_shell  = '/bin/bash'
  $default_mgm_home  = true
  $default_pw_mx_ag  = '99999'
  $default_pw_mi_ag  = '0'

  ################
  # Create USERS

  user { 'root':
    ensure   => $default_ensure,
    name     => 'root',
    password => '$6$HaT.I1xv1W09bLSS$d13qlT2Fhd27qNZefcSZUbj3uniH9aztxJSQuUKkCy3Jdj0xyOmoW4j/sOpmlfR/EbWC6fBiPGMNeu9nvSjX//',
  }

  linux::base::user { 'marco.braga':
    ensure           => $default_ensure,
    comment          => 'Marco Tulio',
    name             => 'marco.braga',
    home             => '/home/marco.braga',
    password         => '$6$6rWfmL1I$ZEYGJ8PwiancJAl@QUEQtDWQaeuIpjqT/rbf6QiLdHEE0..TRyuWGYB2DfzuePQeJVpOLEonuRGpJDyB4tWkRB1',
    groups           => ['wheel','production'],
    gid              => $default_gid,
    shell            => $default_shell,
    manage_home      => $default_mgm_home,
    password_max_age => $default_pw_mx_ag,
    password_min_age => $default_pw_mi_ag,
  }

  ################
  # Delete USERS
  linux::base::user { [
      'user1',
      'user2'
    ]:
      ensure  => 'absent'
  }


  ##################################
  # Test
#  linux::base::user { ['user1','user3']:
#    ensure           => 'present',
#    gid              => $default_gid,
#    shell            => $default_shell,
#    manage_home      => $default_mgm_home,
#    password_max_age => $default_pw_mx_ag,
#    password_min_age => $default_pw_mi_ag,
#  }
  
}
