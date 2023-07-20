# == Class nextcloud::install
#
class nextcloud::install {
  $installcmd = "php occ maintenance:install --database '${nextcloud::db_type}' \
 --database-host ${nextcloud::db_host} \
 --database-name ${nextcloud::db_name} \
 --database-user ${nextcloud::db_user} \
 --database-pass '${nextcloud::db_user_password}' \
 --admin-user ${nextcloud::admin_user} \
 --admin-pass ${nextcloud::admin_password} \
 --data-dir ${nextcloud::data_dir}"

  $tarname = "nextcloud-${nextcloud::version}.tar.bz2"

  file { [$nextcloud::install_dir, $nextcloud::data_dir]:
    ensure => directory,
    owner  => $nextcloud::system_user,
    group  => $nextcloud::system_user,
    mode   => '0700',
  }
  ->  archive { $tarname:
    ensure       => present,
    path         => "/tmp/${tarname}",
    extract      => true,
    extract_path => $nextcloud::base_dir,
    source       => "${nextcloud::src_url}/${tarname}",
    creates      => "${nextcloud::install_dir}/index.php",
    cleanup      => true,
    user         => $nextcloud::system_user,
    group        => $nextcloud::system_user,
  }
  -> exec { 'occ maintenance:install':
    path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    command => $installcmd,
    cwd     => $nextcloud::install_dir,
    user    => $nextcloud::system_user,
    creates => "${nextcloud::install_dir}/config/config.php",
  }
  -> exec { 'occ db:convert-filecache-bigint':
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    command     => 'php occ db:convert-filecache-bigint --no-interaction',
    cwd         => $nextcloud::install_dir,
    user        => $nextcloud::system_user,
    refreshonly => true,
} }
