require 'spec_helper'

describe 'aurora', type: :class do
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
            'allowed_container_types' => %w(DOCKER MESOS),
            'thermos_executor_flags' => [
              '--announcer-enable',
              '--announcer-ensemble=localhost:2181',
              '--announcer-serverset-path=/server',
            ],
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
          executor_flags_match = %r{
              THERMOS_EXECUTOR_FLAGS="
              --announcer-enable\s
              --announcer-ensemble=localhost:2181\s
              --announcer-serverset-path=/server"
          }x
          should contain_file('/etc/default/aurora-scheduler')
            .with_content(/GLOG_v=0/)
            .with_content(/LIBPROCESS_PORT=8083/)
            .with_content(/JAVA_OPTS='\-Djava\.library\.path\=\/usr\/local\/lib'/)
            .with_content(/AURORA_HOME="\/var\/lib\/aurora"/)
            .with_content(/CLUSTER_NAME="mesos"/)
            .with_content(/HTTP_PORT=8081/)
            .with_content(/QUORUM_SIZE=1/)
            .with_content(/ZK_ENDPOINTS="localhost:2181"/)
            .with_content(/MESOS_MASTER=zk:\/\/\${ZK_ENDPOINTS}\/mesos/)
            .with_content(/ZK_SERVERSET_PATH="\/aurora\/scheduler"/)
            .with_content(/ZK_LOGDB_PATH="\/aurora\/replicated-log"/)
            .with_content(/LOGDB_FILE_PATH="\${AURORA_HOME}\/scheduler\/db"/)
            .with_content(/BACKUP_DIR="\${AURORA_HOME}\/scheduler\/backups"/)
            .with_content(/THERMOS_EXECUTOR_PATH="\/usr\/share\/aurora\/bin\/thermos_executor.pex"/)
            .with_content(/THERMOS_EXECUTOR_RESOURCES=""/)
            .with_content(executor_flags_match)
            .with_content(/ALLOWED_CONTAINER_TYPES="DOCKER,MESOS"/)
            .with_content(/GC_EXECUTOR_PATH="\/usr\/share\/aurora\/bin\/gc_executor.pex"/)
            .with_content(/LOG_LEVEL="INFO"/)
            .with_content(/EXTRA_SCHEDULER_ARGS=""/)
        end
      end
    end
  end
end
