class profile_websphere::dmgr(
  $profile_name  = 'PROFILE_01',
  $cell_name     = 'CELL_01',
  $cluster_name  = 'MyCluster01',
  $instance_name = 'WebSphere85',
  $repository    = '/vagrant/ibm/was.repo.8550.ndtrial/repository.config',
  $package       = 'com.ibm.websphere.NDTRIAL.v85',
  $version       = '8.5.5000.20130514_1044',
  $target        = '/opt/IBM/WebSphere/AppServer',
  $profile_base  = '/opt/IBM/WebSphere/AppServer/profiles',
  $user          = 'websphere',
  $wsadmin_user  = 'httpadmin',
  $wsadmin_pass  = 'password',
){
  contain '::profile_websphere::ibm_im'

  websphere_application_server::instance { $instance_name:
    target       => $target,
    package      => $package,
    version      => $version,
    profile_base => $profile_base,
    repository   => $repository,
  } ->

  websphere_application_server::profile::dmgr { $profile_name:
    instance_base    => $target,
    profile_base     => $profile_base,
    cell             => $cell_name,
    node_name        => $::fqdn,
    user             => $user,
    wsadmin_user     => $wsadmin_user,
    wsadmin_pass     => $wsadmin_pass,
    collect_jvm_logs => false,
  } ->

  websphere_application_server::cluster { $cluster_name:
    profile_base => $profile_base,
    dmgr_profile => $profile_name,
    cell         => $cell_name,
  }
}
