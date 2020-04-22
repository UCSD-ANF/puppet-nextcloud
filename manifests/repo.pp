# == Class nextcloud::repo
#
class nextcloud::repo {

  $php_vers = regsubst("${nextcloud::php_version}", "[.]", "", "G")
  $remi_vers = "remi-php${php_vers}"

  if $nextcloud::manage_remi_repo {
    create_resources('yumrepo',{
      'remi'              => {
        descr      => 'Remi\'s RPM repository for Enterprise Linux $releasever - $basearch',
        enabled    => 1,
        mirrorlist =>
        "http://cdn.remirepo.net/enterprise/\$releasever/remi/mirror"
      },
      $remi_vers   => {
        descr      => 'Remi\'s PHP 7.3 RPM repository for Enterprise Linux $releasever - $basearch',
        enabled    => 1,
        mirrorlist =>
        "http://cdn.remirepo.net/enterprise/\$releasever/php${php_vers}/mirror",
        gpgcheck   => 1,
        gpgkey     => 'https://rpms.remirepo.net/RPM-GPG-KEY-remi',
        priority   => 1,
      },
    },{
      protect     => 0,
      priority    => 1,
      gpgcheck    => 1,
      gpgkey      => 'https://rpms.remirepo.net/RPM-GPG-KEY-remi',
    })
  }

  if $nextcloud::manage_epel_repo {

     include epel

  }

}
