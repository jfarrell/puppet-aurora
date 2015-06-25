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

describe 'aurora' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:repo_key) { 'D234932C' }
      let(:params) do
        {
          configure_repo: true,
          repo_key: repo_key,
          repo_url: 'http://apache.org',
        }
      end

      it do
        should contain_apt__source('aurora').with(
          'location' => 'http://apache.org/ubuntu',
          'release' => 'trusty',
          'repos' => 'main',
          'key' => {
            'id' => repo_key,
            'server' => 'pgp.mit.edu',
          },
        )
      end
    end
  end
end
