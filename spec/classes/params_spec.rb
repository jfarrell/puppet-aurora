require 'spec_helper'

describe 'aurora::params', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compiles, not necessarily with dependencies' do
        it { should compile }
      end

      context 'compiles with all dependencies' do
        it { should compile.with_all_deps }
      end

      context 'is present in the catalog' do
        it { should contain_class('aurora::params') }
      end
    end

    context 'on Debian osfamily' do
      let(:facts) do
        {
          osfamily: 'Debian'
        }
      end

      let(:params) do
        {
          manage_package: false
        }
      end

      it do
        should_not compile
      end
    end
  end
end
