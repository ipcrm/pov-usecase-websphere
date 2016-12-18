class profile_websphere::ibm_im (
  $source   = '/vagrant/ibm/agent.installer.linux.gtk.x86_64_1.6.0.20120831_1216.zip',
  $target   = '/opt/IBM/InstallationManager',
  $user     = 'websphere',
  $group    = 'websphere',
  $base_dir = '/opt/IBM',
){

  ensure_packages(['gtk2.i686','libXtst.i686'], {'ensure' => 'present'})

  class { '::ibm_installation_manager':
    deploy_source => true,
    source        => $source,
    target        => $target,
  }

  class {'::websphere_application_server':
    user     => $user,
    group    => $group,
    base_dir => $base_dir,
  }
}
