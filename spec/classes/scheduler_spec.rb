require 'spec_helper'

describe 'aurora::scheduler',  type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          java_opts: [],
          allowed_container_types: %w(DOCKER MESOS),
          extra_scheduler_args: [],
          manage_package: true,
          owner: '$owner',
          group: '$group'
        }
      end

      context 'compiles, not necessarily with all dependencies ' do
        it { should compile }
      end

      context 'compiles with all dependencies' do
        it { should compile.with_all_deps }
      end

      context 'contains the aurora::scheduler class' do
        it { should contain_class('aurora::scheduler') }
      end

      context 'it should contain the aurora::repo class' do
        it { should contain_class('aurora::repo') }
      end

      context 'it should contain the 3 dependency packages aurora-doc, aurora-tools, and aurora-scheduler class' do
        it { should contain_package('aurora-doc') }
        it { should contain_package('aurora-tools') }
        it { should contain_package('aurora-scheduler') }
      end

      context 'contains the file /var/lib/aurora/scheduler/db' do
        let(:ensure) { 'directory' }

        it do
          should contain_file('/var/lib/aurora/scheduler/db')
          should contain_file('/var/lib/aurora/scheduler/db').with_ensure('directory')
          should contain_file('/var/lib/aurora/scheduler/db').with_mode('0644')
          should contain_file('/var/lib/aurora/scheduler/db').with_owner('$owner')
          should contain_file('/var/lib/aurora/scheduler/db').with_group('$group')
          should contain_file('/var/lib/aurora/scheduler/db').with_require('[Package[aurora-scheduler]{:name=>"aurora-scheduler"}, File[/var/lib/aurora/scheduler]{:path=>"/var/lib/aurora/scheduler"}]')
        end

        context 'contains the file /var/lib/aurora/scheduler' do
          it do
            should contain_file('/var/lib/aurora/scheduler')
            should contain_file('/var/lib/aurora/scheduler').with_ensure('directory')
            should contain_file('/var/lib/aurora/scheduler').with_mode('0644')
            should contain_file('/var/lib/aurora/scheduler').with_owner('$owner')
            should contain_file('/var/lib/aurora/scheduler').with_group('$group')
            should contain_package('aurora-scheduler')
          end
        end

        context 'contains the default/aurora-scheduler files' do
          let(:ensure) { 'present' }

          it do
            should contain_file('/etc/default/aurora-scheduler')
            should contain_file('/etc/default/aurora-scheduler').with_ensure('present')
            should contain_file('/etc/default/aurora-scheduler').with_owner('$owner')
            should contain_file('/etc/default/aurora-scheduler').with_group('$group')
            should contain_file('/etc/default/aurora-scheduler').with_mode('0644')
          end
        end

        context 'behaves as expected when :master => true' do
          let(:params) do
            {
              java_opts: [],
              allowed_container_types: %w(DOCKER MESOS),
              extra_scheduler_args: [],
              manage_package: true,
              owner: '$owner',
              group: '$group',
              master: true
            }
          end

          it do
            should contain_exec('init-mesos-log')
          end
        end

        context 'behaves as expected when :master => false' do
          let(:params) do
            {
              master: false
            }
          end
          it do
            should_not contain_exec('init-mesos-log')
          end
        end
      end
    end
  end
end
