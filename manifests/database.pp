# == Class nextcloud::database
#
class nextcloud::database {

  if $nextcloud::manage_db {

    class { '::mysql::server':
      root_password    => $nextcloud::mysql_root_password,
      override_options => $nextcloud::mysql_override_options
    }

    mysql::db { $nextcloud::db_name:
      user         => $nextcloud::db_user,
      password     => $nextcloud::db_user_password,
      host         => $nextcloud::db_host,
      grant        => ['ALL'],
    }
  }

}
