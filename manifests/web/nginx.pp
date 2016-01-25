# == Class profile::web::nginx
# Configure and isntall NGINX web server
#
class profiles::web::nginx (
  $repo_files       = undef,
  $repo_templates   = undef,
  $repo_base        = undef,
  $config_overwrite = 'no',
) inherits profiles::params {

  if $repo_files and $repo_templates and $repo_base {
    class { '::nginx' :
      repo_files     => $repo_files,
      repo_templates => $repo_templates,
      repo_base      => $repo_base,
      reconfig       => $config_overwrite,
    }
  } else {
    class { '::nginx' : }
  }
}
