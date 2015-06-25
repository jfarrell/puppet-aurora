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

class aurora::executor (
  $observer_port = $aurora::observer_port,
){
include aurora::repo

  $packages = [
    'aurora-doc',
    'aurora-executor',
  ]

  package { $packages:
    ensure  => $version,
    require => Class['aurora::repo'],
  }

  file { '/etc/default/thermos':
    ensure  => present,
    content => template('aurora/thermos.erb'),
    mode    => '0644',
    require => Package['aurora-executor'],
  }
}
