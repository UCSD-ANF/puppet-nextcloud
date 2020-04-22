# == Class nextcloud::php
#
class nextcloud::php (
  Optional[Hash] $extensions,
  String $fpm_group,
  String $fpm_user,
  Hash $fpm_pools,
  Optional[Array] $packages,
  Variant[Undef, Hash] $settings,
) {

  if $nextcloud::manage_php {

    ensure_packages($packages)

    class { '::php':
      fpm_user   => $fpm_user,
      fpm_group  => $fpm_group,
      extensions => $extensions,
      settings   => $settings,
      fpm_pools  => $fpm_pools,
    }

  }

}
