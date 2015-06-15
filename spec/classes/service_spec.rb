require 'spec_helper'

describe 'aurora::service' do
  on_supported_os.each do |os, facts|

    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }
      it { should contain_class('aurora::service') }

      let(:params) { { :enable => true } }
      describe 'an executor' do
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
                'File[/etc/default/thermos]'
              ])
            .with_subscribe('File[/etc/default/thermos]')
        end
      end

      describe 'a scheduler' do
        let(:params) { super().merge({ :master => true }) }

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
