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

class aurora (
  $enable                     = aurora::params::enable,
  $version                    = aurora::params::version,
  $master                     = aurora::params::master,
  $init_mesos_log             = aurora::params::init_mesos_log,
  $owner                      = aurora::params::owner,
  $group                      = aurora::params::group,
  $log_level                  = aurora::params::log_level,
  $libmesos_log_verbosity     = aurora::params::libmesos_log_verbosity,
  $libprocess_port            = aurora::params::libprocess_port,
  $java_opts                  = aurora::params::java_opts,
  $cluster_name               = aurora::params::cluster_name,
  $http_port                  = aurora::params::http_port,
  $quorum_size                = aurora::params::quorum_size,
  $zookeeper                  = aurora::params::zookeeper,
  $zookeeper_mesos_path       = aurora::params::zookeeper_mesos_path,
  $zookeeper_aurora_path      = aurora::params::zookeeper_aurora_path,
  $thermos_executor           = aurora::params::thermos_executor,
  $gc_executor                = aurora::params::gc_executor,
  $thermos_executor_resources = aurora::params::thermos_executor_resources,
  $allowed_container_types    = aurora::params::allowed_container_types,
  $extra_scheduler_args       = aurora::params::extra_scheduler_args,
)
