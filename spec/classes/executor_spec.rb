require 'spec_helper'

describe 'aurora::executor', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          observer_port: 1338
        }
      end

      it { should compile }

      it { should contain_class('aurora::executor') }
      it { should contain_package('aurora-executor') }

      it do
        should contain_file('/etc/sysconfig/thermos')
          .with_ensure('present')
          .with_mode('0644')
          .with_require('Package[aurora-executor]')
          .with_content(/--port=1338/)
      end
    end
  end
end
