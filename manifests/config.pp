# == Class nextcloud::config
#
# WIP need to handle all configs for config.php
#
class nextcloud::config {

  $nextcloud::trusted_domains.each | $_index, $_value | {
    exec { "occ config:system:set trusted_domain index ${_index}":
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      command => "php occ config:system:set trusted_domains ${_index} --value=${_value}",
      cwd     => $nextcloud::install_dir,
      user    => $nextcloud::system_user,
      unless  => "php occ config:system:get trusted_domains | grep -qF ${_value}",
    }
  }


}
