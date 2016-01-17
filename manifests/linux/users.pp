# Class: users
#
# This module manages users
#
class profiles::linux::users {

  # Default configuration
  $default_gid    = 'users'
  $default_ensure = 'present'
  $default_shell  = '/bin/bash'
  $default_mgm_home  = true
  $default_pw_mx_ag  = '99999'
  $default_pw_mi_ag  = '0'

  #################
  # Create groups
  group { [$default_gid,'whell','sysadmins']:
    ensure => present,
  }

  ################
  # Create USERS

  ## FULL Admin [whell]
  user { 'marco.braga':
    ensure           => $default_ensure,
    comment          => 'CGI INFRA - Marco Tulio',
    name             => 'mtulio',
    home             => '/home/marco.braga',
    password         => '$6$GpTlgkVr$CHLWoyzd4fGD/c4eG2A5JnR8HvsrUF0sGnHrpumysSsJRW5laOfMrvuYX3qjlLriQXGQVHqLq8UIpOxe9Wz2C1', # admin@123
    groups           => ['whell','sysadmin'],
    gid              => $default_gid,
    shell            => $default_shell,
    managehome       => $default_mgm_home,
    password_max_age => $default_pw_mx_ag,
    password_min_age => $default_pw_mi_ag,
  }

  user { 'admin02':
    ensure           => $default_ensure,
    comment          => 'Sysadmin 02',
    name             => 'sysadmin02',
    home             => '/home/sysadmin02',
    password         => '$6$GpTlgkVr$CHLWoyzd4fGD/c4eG2A5JnR8HvsrUF0sGnHrpumysSsJRW5laOfMrvuYX3qjlLriQXGQVHqLq8UIpOxe9Wz2C1', # admin@123
    groups           => ['whell','sysadmins'],
    gid              => $default_gid,
    shell            => $default_shell,
    managehome       => $default_mgm_home,
    password_max_age => $default_pw_mx_ag,
    password_min_age => $default_pw_mi_ag,
  }

  user { 'user01':
    ensure           => $default_ensure,
    comment          => 'CGI INFRA - User 01',
    name             => 'user01',
    home             => '/home/user01',
    password         => '$6$GpTlgkVr$CHLWoyzd4fGD/c4eG2A5JnR8HvsrUF0sGnHrpumysSsJRW5laOfMrvuYX3qjlLriQXGQVHqLq8UIpOxe9Wz2C1', # admin@123
    gid              => $default_gid,
    shell            => $default_shell,
    managehome       => $default_mgm_home,
    password_max_age => $default_pw_mx_ag,
    password_min_age => $default_pw_mi_ag,
  }
}
