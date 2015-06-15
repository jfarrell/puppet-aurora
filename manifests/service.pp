class aurora::service (
  $enable = $aurora::enable,
  $master = $aurora::master,
){
  include aurora::install
  include aurora::params

  case $::operatingsystem {
    'Ubuntu': {
      $provider = 'upstart'
    }
    default: {
      $provider = undef
    }
  }

  if $master{
    service { 'aurora-scheduler':
      ensure     => running,
      enable     => $enable,
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
      enable     => $enable,
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
