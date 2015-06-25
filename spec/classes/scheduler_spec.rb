require 'spec_helper'

describe 'aurora', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          manage_package: true,
          master: true,
          scheduler_options: {
            'observer_port' => '1338',
            'log_level' => 'INFO',
            'libmesos_log_verbosity' => 0,
            'libprocess_port' => '8083',
            'java_opts' => ['-Djava.library.path=/usr/local/lib'],
            'cluster_name' => 'mesos',
            'http_port' => '8081',
            'quorum_size' => 1,
            'zookeeper' => 'localhost:2181',
            'zookeeper_mesos_path' => 'mesos',
            'zookeeper_aurora_path' => 'aurora',
            'thermos_executor' => '/usr/share/aurora/bin/thermos_executor.pex',
            'gc_executor' => '/usr/share/aurora/bin/gc_executor.pex',
            'thermos_executor_resources' => '',
            'allowed_container_types' => ['DOCKER','MESOS'],
            'extra_scheduler_args' => [],
          },
        }
      end

      it { should compile.with_all_deps }

      it { should contain_class('aurora::scheduler') }

      it { should contain_package('aurora-doc') }
      it { should contain_package('aurora-tools') }
      it { should contain_package('aurora-scheduler') }

      it { should contain_exec('init-mesos-log') }

      it do
        should contain_file('/var/lib/aurora/scheduler/db')
          .with_ensure('directory')
          .with_mode('0644')
          .with_owner('aurora')
          .with_group('aurora')
          .with_require('[Package[aurora-scheduler]{:name=>"aurora-scheduler"}, File[/var/lib/aurora/scheduler]{:path=>"/var/lib/aurora/scheduler"}]')
      end

      it do
        should contain_file('/var/lib/aurora/scheduler')
          .with_ensure('directory')
          .with_mode('0644')
          .with_owner('aurora')
          .with_group('aurora')
      end

      it do
        should contain_file('/etc/default/aurora-scheduler')
          .with_ensure('present')
          .with_owner('aurora')
          .with_group('aurora')
          .with_mode('0644')
      end

      context 'scheduler params' do
        it do
          should contain_file('/etc/default/aurora-scheduler')
            .with_content(/CLUSTER_NAME="mesos"/)
        end
      end
    end
  end
end
