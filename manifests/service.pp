class aurora::service {
  case $::os['name'] {
    'Ubuntu': {
      $provider = 'upstart'
    }
    default: {
      $provider = undef
    }
  }

  if $aurora::master {
    service { 'aurora-scheduler':
      ensure     => running,
      enable     => $aurora::params::enable,
      hasstatus  => true,
      hasrestart => true,
      require    => Package['aurora-scheduler'],
      provider   => $provider,
    }
  }
  else {
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
  }

}
