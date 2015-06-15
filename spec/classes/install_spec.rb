require 'spec_helper'
#module name: aurora

describe 'aurora::install' do

  context 'The catalog should at the very least compile' do
    it { should compile.with_all_deps }
  end

  context 'The main aurora class should be present in the catalog' do
    it { should contain_class('aurora') }
  end
end

# should the context below be in a subclass test?
context 'The subclass aurora::master should be present in the catalog' do
  it { should contain_class('aurora::master') } # double check if this master is a resource or a class
end

context 'The manifest should not contain more than 2 classes' do
  it { should have_class_count(2) }
end


  context 'with master => true' do
    let(:params) { {'aurora::master' => true} }

    it do
      should include_class('aurora::scheduler')
      should_not include_class('aurora::executor')
    end
  end

  context 'with master => default' do
    let(:params) { {'aurora::master' => 'default'} }

    it do
      should include_class('aurora::executor')
      should_not include_class('aurora::scheduler')
    end
  end
