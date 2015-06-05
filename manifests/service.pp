class aurora::service {
  case $::osname {
    'Ubuntu': {
      $provider = 'upstart'
    }
    default: {
      $provider = ''
    }
  }

  service { 'thermos':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => $aurora::params::enable,
    provider   => $provider,
    require    => [
      Package['aurora-executor'],
      File['/etc/default/thermos'],
    ],
    subscribe  => [
      File['/etc/default/thermos'],
    ],
  }

  service { 'aurora-scheduler':
    ensure  => running,
    enable  => $aurora::params::enable,
    require => Package['aurora-executor'],
  }
}
