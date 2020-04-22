class nextcloud (
  Variant[Undef, String] $admin_user,
  Variant[Undef, String] $admin_password,
  Stdlib::Absolutepath $base_dir,
  Stdlib::Absolutepath $data_dir,
  String $db_host,
  String $db_name,
  Variant[Undef, String] $db_table_prefix,
  String $db_type,
  String $db_user,
  String $db_user_password,
  String $fpm_user,
  String $fpm_group,
  String $install_dir,
  Boolean $manage_db,
  Boolean $manage_php,
  Boolean $manage_redis,
  Boolean $manage_epel_repo,
  Boolean $manage_remi_repo,
  Boolean $manage_web,
  Optional[Hash] $mysql_override_options,
  String $mysql_root_password,
  Hash $php_fpm_pools,
  String $php_version,
  Optional[Array] $redis_packages,
  String $remi_repo_vers,
  String $src_url,
  String $src_tar,
  String $system_user,
  Array $trusted_domains,
  String $version,
) {

  contain nextcloud::database
  contain 'nextcloud::webserver'
  contain 'nextcloud::repo'
  contain 'nextcloud::php'
  contain 'nextcloud::install'
  contain 'nextcloud::config'
  contain 'nextcloud::redis'

  Class['nextcloud::database']
  -> Class['nextcloud::webserver']
  -> Class['nextcloud::repo']
  -> Class['nextcloud::php']
  -> Class['nextcloud::install']
  -> Class['nextcloud::config']
  -> Class['nextcloud::redis']

}
  
