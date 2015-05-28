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

class aurora::params {
  $enable = true
  $version = undef
  $manage_package = false
  $master = false
  $init_mesos_log = false
  $owner = 'aurora'
  $group = 'aurora'
  $log_level = 'INFO'
  $libmesos_log_verbosity = 0
  $libprocess_port = '8083'
  $java_opts = ['-Djava.library.path=/usr/local/lib']
  $cluster_name = 'mesos'
  $http_port = '8081'
  $quorum_size = 1
  $zookeeper = 'localhost:2181'
  $zookeeper_mesos_path = 'mesos'
  $zookeeper_aurora_path = 'aurora'
  $thermos_executor = '/usr/share/aurora/bin/thermos_executor.pex'
  $gc_executor = '/usr/share/aurora/bin/gc_executor.pex'
  $thermos_executor_resources = ''
  $allowed_container_types = ['DOCKER','MESOS']
  $extra_scheduler_args = ['-enable_beta_updater=true']

  case $::osfamily {
    'Debian': {
      $manage_package = true
    }
    default: {
      $manage_package = false
    }
  }

}

