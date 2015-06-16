require 'spec_helper'
# '$aurora::owner'= 'aurora'
# '$aurora::owner' = 'aurora'

$default_package = ['aurora-doc','aurora-scheduler','aurora-tools',]
#$default_scheduler_file_attr =

describe 'aurora::scheduler' do
  on_supported_os.each do |os, facts|

    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          :java_opts => [],
          :allowed_container_types => ['DOCKER', 'MESOS'],
          :extra_scheduler_args => [],
          :manage_package => true,
        }
      end
      it { should compile.with_all_deps }
    end
  end
end
