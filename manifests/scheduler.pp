# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class aurora::scheduler (
  $version = $aurora::version,
  $ensure = $aurora::ensure,
  $owner = $aurora::owner,
  $group = $aurora::group,
  $master = $aurora::master,
  $manage_package = $aurora::manage_package,
  $libmesos_log_verbosity = $aurora::libmesos_log_verbosity,
  $libprocess_port = $aurora::libprocess_port,
  $java_opts = $aurora::java_opts,
  $cluster_name = $aurora::cluster_name,
  $http_port = $aurora::http_port,
  $quorum_size = $aurora::quorum_size,
  $zookeeper = $aurora::zookeeper,
  $zookeeper_mesos_path = $aurora::zookeeper_mesos_path,
  $zookeeper_aurora_path = $aurora::zookeeper_aurora_path,
  $thermos_executor = $aurora::thermos_executor,
  $thermos_executor_resources = $aurora::thermos_executor_resources,
  $thermos_executor_flags = $aurora::thermos_executor_flags,
  $allowed_container_types = $aurora::allowed_container_types,
  $gc_executor = $aurora::gc_executor,
  $log_level = $aurora::log_level,
  $extra_scheduler_args = $aurora::extra_scheduler_args,

){
  include aurora::repo

  $aurora_ensure = $version? {
    undef    => 'absent',
    default => $version,
  }

  $packages = [
    'aurora-doc',
    'aurora-scheduler',
    'aurora-tools',
  ]

  if $manage_package {
    package { $packages:
      ensure  => $ensure,
      require => Class['aurora::repo'],
    }
    $aurora_require = Package['aurora-scheduler']
    file { '/var/lib/aurora/scheduler':
      ensure  => directory,
      owner   => $owner,
      group   => $group,
      mode    => '0644',
      require => Package['aurora-scheduler'],
    }

    file { '/var/lib/aurora/scheduler/db':
      ensure  => directory,
      owner   => $owner,
      group   => $group,
      mode    => '0644',
      require => [
        Package['aurora-scheduler'],
        File['/var/lib/aurora/scheduler'],
      ]
    }

    file { '/etc/default/aurora-scheduler':
      ensure  => present,
      content => template('aurora/aurora-scheduler.erb'),
      owner   => $owner,
      group   => $group,
      mode    => '0644',
      require => $aurora_require
    }

    if $master {
      exec { 'init-mesos-log':
        command => '/usr/bin/mesos-log initialize --path=/var/lib/aurora/scheduler/db && /bin/chown aurora:aurora /var/lib/aurora/scheduler/db/*',
        unless  => '/usr/bin/test -f /var/lib/aurora/scheduler/db/CURRENT',
        require => Package['aurora-scheduler'],
        notify  => Service['aurora-scheduler'],
      }
    }
  }
}
