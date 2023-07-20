# == Class nextcloud::redis
#
class nextcloud::redis {
  if $nextcloud::manage_redis {
    include redis

    ensure_packages($nextcloud::redis_packages)

    # add to config.php
    exec { 'occ config:system:set memcache.local':
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      command => "php occ config:system:set 'memcache.local' --value='\\OC\\Memcache\\Redis'",
      cwd     => $nextcloud::install_dir,
      user    => $nextcloud::system_user,
      unless  => "php occ config:system:get 'memcache.local' | grep -qF '\\OC\\Memcache\\Redis'",
  } }
}
