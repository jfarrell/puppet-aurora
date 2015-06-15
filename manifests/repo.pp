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
class aurora::repo(
  $configure = $aurora::configure_repo,
  $repo_url = $aurora::repo_url,
  $repo_key = $aurora::repo_key
){

  if $aurora::configure_repo {
    case $::osfamily {
      'Debian': {
        $distro = downcase($::operatingsystem)
        $repo   = 'main'
        $repo_name   = 'aurora'
        $key_server = 'pgp.mit.edu'

        apt::source { $repo_name:
          location => "${aurora::repo_url}/${distro}",
          release  => $::lsbdistcodename,
          repos    => $repo,
          key      => {
            'id'     => $aurora::repo_key,
            'server' => $key_server,
          },
        }
      }
      default: {
      }
    }
  }

}
