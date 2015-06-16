require 'spec_helper'

describe 'aurora::install', type: :class do
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
        it { should contain_class('aurora::install') }
      end
    end

    context 'contains 3 classes' do
      it { should have_class_count(3) }
    end

    describe 'aurora::install contains the correct classes when master => true' do
      let(:params) {
         {
           master: true
         }
      }

      it do
        should contain_class('aurora::scheduler')
        should_not contain_class('aurora::executor')
      end
    end

    describe 'aurora::install contains the correct classes when master => default' do
      let(:params) {
        {
          master: 'default'
        }
      }

      it do
        should contain_class('aurora::executor')
        should_not contain_class('aurora::scheduler')
      end
    end
  end
end
