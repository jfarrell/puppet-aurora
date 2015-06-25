require 'spec_helper'

describe 'aurora', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compiles with all dependencies' do
        it { should compile.with_all_deps }
      end

      context 'is present in the catalog' do
        it { should contain_class('aurora::params') }
      end
    end
  end
end
