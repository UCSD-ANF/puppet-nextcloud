# == Class nextcloud::webserver
#
class nextcloud::webserver (
  Hash $resource_location,
  Hash $resource_server,
  String $server_name,
  Integer $worker_processes,
) {

  class { 'nginx':
    manage_repo      => false,
    worker_processes => $worker_processes,
  }

  create_resources('nginx::resource::server', $resource_server)
  create_resources('nginx::resource::location', $resource_location, {
    ensure        => 'present',
    index_files   => [],
    server        => $server_name,
    ssl           => true,
    ssl_only      => true,
  })

}
