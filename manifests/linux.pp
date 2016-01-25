#
# == Class: profiles linux
#
class profiles::linux (
  $security_level    = 'basic',
  $repo_base         = undef,
  $pool              = udnef,

  ## Linux->NTP Options ##
  $gb_ntp_server        = $profiles::params::gb_ntp_server,

  ## Linux->RESOLV_CONF options ##
  $gb_resconf_ns        = $profiles::params::gb_resconf_ns,
  $gb_resconf_opts      = $profiles::params::gb_resconf_opts,

  ## Linux->TIMEZONE ##
  $gb_timezone          = $profiles::params::gb_timezone,

  ## Zabbix->Agent ##
  $gb_zabbix_a_server   = $gb_zabbix_a_server,

  ## SSH->sshd_config ##
  $gb_sshd_usr_lc_en    = $profiles::params::gb_sshd_usr_lc_en,
  $gb_sshd_usr_name_ens = $profiles::params::gb_sshd_usr_name_ens,
  $gb_sshd_usr_password = $profiles::params::gb_sshd_usr_password,
  $gb_sshd_perm_root_lg = $profiles::params::gb_sshd_perm_root_lg,
  $gb_sshd_allow_users  = $profiles::params::gb_sshd_allow_users,
  $gb_sshd_bannerpath   = $profiles::params::gb_sshd_bannerpath,
) inherits profiles::params {

  if $repo_base == undef or $pool == undef {
    $default_config = 'yes'
  }

  #######################
  ## Users
  class { '::profiles::linux::users': }
  
  #######################
  #> Module required [mtulio-linux]: puppet module install mtulio-linux

  ###> Config NTPDATE: linux->NTPDATE
  class { '::linux::base::ntpdate' :
    ntpserver => $gb_ntp_server,
  }
  
  ###> Config linux->TIMEZONE
  class { '::linux::base::timezone' :
    timezone => $gb_timezone,
  }

  if $default_config == 'yes' {

    ###> Config linux->MOTD
    class { '::linux::base::motd' : }

    ###> Config linux->HOSTS
    class { '::linux::base::hosts' : }

    ###> Config linux->RESOLV.CONF
    class { '::linux::base::resolv_conf' :
      domainname  => $::domain,
      nameservers => $gb_resconf_ns,
      options     => $gb_resconf_opts,
    }
    
    ###> Config linux->SUDOERS
    class { '::linux::base::sudoers' : }

    ##> SSH->sshd_config
    $sshd_banner = 'yes'
    $sshd_banner_path = 'ssh/sshd_banner_example_pt-br'
  }
  else {

    ###> Config linux->MOTD
    class { '::linux::base::motd' :
        template => "${repo_base}/motd/pool_default/motd.erb",
    }
    
    ###> Config linux->HOSTS
    class { '::linux::base::hosts' :
        #template => "${repo_base}/hosts/hosts.erb",
    }

    ###> Config linux->RESOLV.CONF
    class { '::linux::base::resolv_conf' :
      template => "${repo_base}/resolv_conf/resolv.conf.erb",
    }
    
    ###> Config linux->SUDOERS
    class { '::linux::base::sudoers' :
      template => "${repo_base}/sudoers/sudoers",
    }
    
    ##> SSH->sshd_config
    $sshd_banner = 'yes'
    $sshd_banner_path = "${repo_base}/ssh/sshd/mte_mensagem"
  }


  ### linux_Security
  case $security_level {
    'basic': {
      notice('Disable all security options')
      #> disable iptables

      ###> Config linux->SELINUX
      class {'::linux::security::selinux' :
        mode => permissive,
      }
    }
    'high' : {
      notice('Enable all security options')
      #> enable iptables
      #> enable audit
    
      ###> Config linux->SELINUX
      class {'::linux::security::selinux' :
        mode => enforcing,
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
  #> Module required [mtulio-ssh]: 
  ## Class: SSH->sshd_config
  if $sshd_banner == 'yes' {
    file { $gb_sshd_bannerpath:
      path   => $gb_sshd_bannerpath,
      source => "puppet:///modules/${sshd_banner_path}",
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
    class { '::ssh::sshd_config':
      user_local_enable => $gb_sshd_usr_lc_en,
      user_name_ensure  => $gb_sshd_usr_name_ens,
      user_password     => $gb_sshd_usr_password,
      permitrootlogin   => $gb_sshd_perm_root_lg,
      allow_groups      => $gb_sshd_allow_groups,
      bannerpath        => $gb_sshd_bannerpath,
    }
  }
  else {
    class { '::ssh::sshd_config':
      user_local_enable => $gb_sshd_usr_lc_en,
      user_name_ensure  => $gb_sshd_usr_name_ens,
      user_password     => $gb_sshd_usr_password,
      permitrootlogin   => $gb_sshd_perm_root_lg,
      allow_groups      => $gb_sshd_allow_groups,
    }
  }


}

