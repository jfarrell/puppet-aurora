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
  $enable                     = ensure_bool($aurora::params::enable),
  $version                    = $aurora::params::version,
  $master                     = ensure_bool($aurora::params::master),
  $owner                      = $aurora::params::owner,
  $group                      = $aurora::params::group,
  $manage_package             = $aurora::params::manage_package,
  $repo_url                   = $aurora::params::repo_url,
  $repo_key                   = $aurora::params::repo_key,
  $configure_repo             = $aurora::params::configure_repo,
  $scheduler_options          = $aurora::params::scheduler_options,
) inherits aurora::params {

  if $scheduler_options {
    if $scheduler_options['log_level'] {
      validate_string($scheduler_options['log_level'])
    }
    if $scheduler_options['libprocess_port'] {
      validate_string($scheduler_options['libprocess_port'])
    }
    if $scheduler_options['java_opts'] {
      validate_array($scheduler_options['java_opts'])
    }
    if $scheduler_options['cluster_name'] {
      validate_string($scheduler_options['cluster_name'])
    }
    if $scheduler_options['http_port'] {
      validate_integer($scheduler_options['http_port'])
    }
    if $scheduler_options['quorum_size'] {
      validate_integer($scheduler_options['quorum_size'])
    }
    if $scheduler_options['libmesos_log_verbosity'] {
      validate_string($scheduler_options['libmesos_log_verbosity'])
    }
    if $scheduler_options['zookeeper'] {
      validate_string($scheduler_options['zookeeper'])
    }
    if $scheduler_options['zookeeper_mesos_path'] {
      validate_string($scheduler_options['zookeeper_mesos_path'])
    }
    if $scheduler_options['zookeeper_aurora_path'] {
      validate_string($scheduler_options['zookeeper_aurora_path'])
    }
    if $scheduler_options['thermos_executor'] {
      validate_absolute_path($scheduler_options['thermos_executor'])
    }
    if $scheduler_options['gc_executor'] {
      validate_absolute_path($scheduler_options['gc_executor'])
    }
    if $scheduler_options['thermos_executor_resources'] {
      validate_absolute_path($scheduler_options['thermos_executor_resources'])
    }
    if $scheduler_options['allowed_container_types'] {
      validate_array($scheduler_options['allowed_container_types'])
    }
    if $scheduler_options['extra_scheduler_args'] {
      validate_array($scheduler_options['extra_scheduler_args'])
    }
    if $scheduler_options['observer_port'] {
      validate_integer($scheduler_options['observer_port'])
    }
  }

  validate_string($scheduler_options['repo_url'])
  validate_string($owner)
  validate_string($group)
  validate_string($repo_key)
  validate_string($repo_url)

  contain aurora::repo
  contain aurora::install
  contain aurora::service

  Class['aurora::repo'] ->
  Class['aurora::install'] ->
  Class['aurora::service']
}
