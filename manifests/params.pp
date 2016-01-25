# == Class: Profiles/parameters
class profiles::params {

  ## Linux->NTP Options ##
  $gb_ntp_server = 'pool.ntp.br'

  ## Linux->RESOLV_CONF options ##
  $gb_resconf_ns = ['10.0.2.3','8.8.8.8','201.67.222.222']
  $gb_resconf_opts = ['rotate']

  ## Linux->TIMEZONE ##
  $gb_timezone = 'America/Sao_Paulo'

  ## Zabbix->Agent ##
  $gb_zabbix_a_server = 'zabbix.local'

  ## SSH->sshd_config ##
  $gb_sshd_usr_lc_en    = 'no'
  $gb_sshd_usr_name_ens = 'production'
  $gb_sshd_usr_password = '$6$GpTlgkVr$CHLWoyzd4fGD/c4eG2A5JnR8HvsrUF0sGnHrpumysSsJRW5laOfMrvuYX3qjlLriQXGQVHqLq8UIpOxe9Wz2C1' # admin@123
  $gb_sshd_perm_root_lg = 'no'
  $gb_sshd_deny_users   = undef
  $gb_sshd_allow_users  = 'marco.braga production'
  $gb_sshd_deny_groups  = undef
  $gb_sshd_allow_groups = 'wheel'
  $gb_sshd_bannerpath   = '/etc/ssh/banner'
}
