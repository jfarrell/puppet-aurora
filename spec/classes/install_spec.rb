require 'spec_helper'

describe 'aurora', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let (:params) do
        {
          master: true
        }
      end

      it { should compile.with_all_deps }

      it { should contain_class('aurora::install') }

      context 'when master => true' do
        it do
          should contain_class('aurora::scheduler')
          should_not contain_class('aurora::executor')
        end
      end

      context 'when master => false' do
        let (:params) do
          {
            master: false
          }
        end

        it do
          should contain_class('aurora::executor')
          should_not contain_class('aurora::scheduler')
        end
      end
    end
  end
end
