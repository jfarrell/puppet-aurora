require 'spec_helper'

describe 'aurora', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          enable: true
        }
      }

      it { should compile.with_all_deps }

      it { should contain_class('aurora::service') }

      it do
        should contain_service('thermos')
          .with_ensure('running')
          .with_hasstatus('true')
          .with_hasrestart('true')
          .with_enable('true')
          .with_provider('upstart')
          .with_require(
            [
              'Package[aurora-executor]',
              'File[/etc/sysconfig/thermos]'
            ])
          .with_subscribe('File[/etc/sysconfig/thermos]')
      end

      describe 'a scheduler' do
        let(:params) { super().merge(master: true) }

        it do
          should contain_service('aurora-scheduler')
            .with_ensure('running')
            .with_enable('true')
            .with_hasstatus('true')
            .with_hasrestart('true')
            .with_require('Package[aurora-scheduler]')
            .with_provider('upstart')
        end
      end
    end
  end
end
