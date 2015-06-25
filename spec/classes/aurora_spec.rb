require 'spec_helper'

describe 'aurora' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          version: '0.9.0',
          enable: true,
          configure_repo: false,
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

      it { should compile }
      it { should contain_class('aurora::params') }
      it { should contain_class('aurora') }
      it { should contain_class('aurora::repo') }

      context 'scheduler options' do
        context 'with an invalid array parameter' do
          let (:params) do
            params = super()
            params[:scheduler_options].merge!('java_opts' => 'test')
            params
          end
          it { should raise_error(Puppet::Error, /is not an Array/)}
        end
      end
    end
  end
end
