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
          enable: true
        }
      end

      context 'it should at least compile' do
        it do
          expect do
            should include_class('aurora::params')
          end
        end
      end

      # describe 'aurora' do
      #   on_supported_os.each do |os, facts|
      #     context "on #{os}" do
      #       let(:facts) do
      #         facts
      #       end
      #
      #
      # end
      # end

      # describe 'aurora' do
      #   on_supported_os.each do |os, facts|
      #     context "on #{os}" do
      #       let(:facts) do
      #         facts
      #       end
      #
      #       let(:params) do
      #         {
      #            version: '0.9.0',
      #           enable: true
      #         }
      #       end
      context 'when params that should be Arrays are Arrays' do
        let(:params) do
          {
            java_opts: ['-Djava.library.path=/usr/local/lib'],
            allowed_container_types: %w(DOCKER MESOS),
            extra_scheduler_args: []
          }
        end
        it do
          expect do
            should compile
          end
        end
      end
      context 'when params that should be Arrays are NOT Arrays' do
        let(:params) do
          {
            java_opts: '-Djava.library.path=/usr/local/lib',
            allowed_container_types: 'DOCKER',
            extra_scheduler_args: ''
          }
        end
        it do
          expect do
            should compile
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError, /is not an Array/)
        end
      end

      context 'when params that should be Strings are Strings' do
        let(:params) do
          {
            owner: 'aurora',
            group: 'aurora',
            log_level: 'INFO',
            libprocess_port: '8083',
            cluster_name: 'mesos',
            http_port: '8081',
            zookeeper: 'localhost:2181',
            zookeeper_mesos_path:  'mesos',
            zookeeper_aurora_path: 'aurora',
            thermos_executor: '/usr/share/aurora/bin/thermos_executor.pex',
            gc_executor: '/usr/share/aurora/bin/gc_executor.pex',
            thermos_executor_resources: '',
            repo_url: 'http://www.apache.org/dist/aurora/',
            observer_port: '1338'
          }
        end
        it do
          expect do
            should compile
          end
        end
      end

      context 'when params that should be Strings are NOT Strings' do
        let(:params) do
          {
            owner: true,
            group: 0,
            log_level: 0,
            libprocess_port: 8083,
            cluster_name: 2,
            http_port: 8081,
            zookeeper: ['localhost:2181'],
            zookeeper_mesos_path: 'mesos',
            zookeeper_aurora_path: false,
            thermos_executor: ['/usr/share/aurora/bin/thermos_executor.pex'],
            gc_executor: ['/usr/share/aurora/bin/gc_executor.pex'],
            thermos_executor_resources: [],
            repo_url: ['http://www.apache.org/dist/aurora/'],
            observer_port: 1338
          }
        end
        it do
          expect do
            should compile
          end.to raise_error(RSpec::Expectations::ExpectationNotMetError, / not a string/)
        end
      end

      #     end
      # end
      # end
      # #end
      # describe 'aurora' do
      #   on_supported_os.each do |os, facts|
      #     context "on #{os}" do
      #       let(:facts) do
      #         facts
      #       end
      #
      #       let(:params) do
      #         {
      #            version: '0.9.0',
      #           enable: true
      #         }
      #       end
      context 'when master => "false"' do
        let(:params) do
          {
            master: 'false',
            init_mesos_log: 'true'
          }
        end

        it do
          expect do
            should include_class('aurora::params')
          end
        end

        it do
          expect do
            should compile
          end
        end
      end

      context 'when master => "bar"' do
        let(:params) do
          {
            master: 'bar',
            init_mesos_log: true
          }
        end

        it do
          expect do
            should include_class('aurora::params')
          end
        end

        it do
          expect do
            should_not compile
          end
        end
      end

      context 'when master => 5' do
        let(:params) do
          {
            master: 5,
            init_mesos_log: true
          }
        end

        it do
          expect do
            should_not compile
          end
        end
      end

      context 'when master => ""' do
        let(:params) do
          {
            master: '',
            init_mesos_log: true
          }
        end

        it do
          expect do
            should_not compile
          end
        end
      end

      context 'when params that should be Numeric are Numeric' do
        let(:params) do
          {
            libmesos_log_verbosity: '0',
            quorum_size: 1
          }
        end

        it do
          expect do
            should compile
          end
        end
      end

      context 'when params that should be Numeric are NOT Numeric' do
        let(:params) do
          {

            quorum_size: '1'
          }
        end

        it do
          expect do
            should_not compile
          end
        end
      end
    end
  end
end
