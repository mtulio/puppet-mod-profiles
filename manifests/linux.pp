# == Class: profiles Linux
class profiles::linux (
  $security_level = 'basic',
  $gb_repo_base   = $gb_repo_base,
  $gb_pool        = $gb_pool,
) inherits profiles {

  if $gb_repo_base == undef or $gb_pool == undef {
    $default_config = 'yes'
  }

  #######################
  ## Users
  class { '::profiles::linux::users': }
  
  #######################
  #> puppet linux module: mtulio/linux
  ##> Require: puppet module install mtulio-linux

  ###> Config linux->HOSTS
  class { '::linux::base::hosts' : }

  ###> Config linux->MOTD
  if $default_config == 'yes' {
    class { '::linux::base::motd' : }
  }
  else {
    class { '::linux::base::motd' :
        template => "${gb_repo_base}/motd/pool_${gb_pool}/motd.erb",
    }
  }

  ###> Config linux->NTPDATE
  class { '::linux::base::ntpdate' :
    ntpserver => 'a.ntp.br',
  }

  ###> Config linux->RESOLV.CONF
  if $default_config == 'yes' {
    class { '::linux::base::resolv_conf' :
      nameservers => ['10.0.2.3','8.8.8.8','201.67.222.222'],
      domainname  => $::domain,
    }
  }
  else {
    class { '::linux::base::resolv_conf' :
      template     => "${gb_repo_base}/resolv_conf/resolv.conf.erb",
    }
  }

  ###> Config linux->TIMEZONE
  class { '::linux::base::timezone' :
    timezone => 'America/Sao_Paulo',
  }
  
  ###> Config linux->SUDOERS
  if $default_config == 'yes' {
    class { '::linux::base::sudoers' : }

  } else {
    class { '::linux::base::sudoers' :
      template => "${gb_repo_base}/sudoers/sudoers",
    }
  }

  ### linux_Security
  case $security_level {
    'basic': {
      notice('Disable all security options')
      #include profiles::linux::sec_basic
      #> disable selinux
      #> disable iptables

      ###> Config linux->SELINUX
      class {'::linux::security::selinux' :
        mode => permissive,
      }
    }
    'high' : {
      notify('Enable all security options')
      #include profiles::linux::sec_high
      #> enable selinux
      #> enable iptables
      #> enable audit
    
      ###> Config linux->SELINUX
      class {'::linux::security::selinux' :
        mode => enforced,
      }
    }
    default : {
      ###> Config linux->SELINUX
      class {'::linux::security::selinux' :
        mode => disabled,
      }
    }
  }

  #######################
  #> Module: ssh
  ## Test 1
  #class { '::ssh::sshd_config':  }
  
  ## Test 2
  #class { '::ssh::sshd_config':
  #  permitrootlogin   => 'yes',
  #  allow_users       => 'root prod',
  #}
  # SSHd_config class - Test 3: Ensure Local User, block root login

  ## Test 3
  class { '::ssh::sshd_config':
    user_local_enable => 'yes',
    user_name_ensure  => 'lmtulio',
    user_password     => '$6$GpTlgkVr$CHLWoyzd4fGD/c4eG2A5JnR8HvsrUF0sGnHrpumysSsJRW5laOfMrvuYX3qjlLriQXGQVHqLq8UIpOxe9Wz2C1', # admin@123
    permitrootlogin   => 'yes',
    allow_users       => 'root ltulio',
  }
}

