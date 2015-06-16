require 'spec_helper'

describe 'aurora::executor', type: :class do
  it { should compile }

  context 'it should contain the aurora::executor class' do
    it { should contain_class('aurora::executor') }
  end

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
          owner: 'aurora',
          group: 'aurora',
          observer_port: '1338'
        }
      end

      context 'has the correct number of dependency resources and classes available' do
        it { should have_class_count(2) }
        it { should have_resource_count(3) }
      end

      context 'default file in an executor' do
        let(:params) do
          {
            ensure: '0.9.0'
          }
        end

        let(:thermos_template_content) do
          "# Defaults for thermos observer\n\n# Listen port for thermos_observer\n# set to 1338 as default\nOBSERVER_PORT=\n" # set to 1338 as default\n            OBSERVER_PORT=1338"}
        end

        it do
          should contain_package('aurora-doc', 'aurora-executor')
        end

        it do
          should contain_file('/etc/default/thermos')
          should contain_file('/etc/default/thermos').with_ensure('present')
          should contain_file('/etc/default/thermos').with_mode('0644')
          should contain_file('/etc/default/thermos').with_require('Package[aurora-executor]')
          should contain_file('/etc/default/thermos').with_content(thermos_template_content)
        end

        it do
          should_not contain_file('/etc/default/thermos').with_owner('root')
        end

        # check that name $packages is an array of exactly 2 resources,
        it do
          should have_package_resource_count(2)
        end
      end

      context 'contains Package[aurora-doc]' do
        it do
          should contain_package('aurora-doc')
          should contain_package('aurora-executor')
        end
      end

      context 'includes the aurora::repo class as dependency' do
        it do
          should contain_class('aurora::repo')
        end
      end

      context 'does not compile when the thermos file is absent' do
        let('bad_attributes') do
          { ensure: 'present',
            mode: '0644',
            require: 'Package[aurora-executor]',
            source: ''
        }
        end

        it do
          should_not contain_file('/etc/default/thermos').with(bad_attributes)
          expect { should_not compile }
        end
      end
    end
  end
end
