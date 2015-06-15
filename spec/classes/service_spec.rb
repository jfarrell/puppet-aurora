require 'spec_helper'
# test
describe 'aurora::service' do

  context 'The catalog should at the very least compile' do
    it {
         should compile
    }
  end

  context 'The main aurora class should be present in the catalog' do
    it {
         should contain_class('aurora')
    }
  end
end

# should the context below be in a subclass test?
context 'The subclass aurora::master should be present in the catalog' do
  it {
       should contain_class('aurora::master')
  }
end

# test that either the service aurora-scheduler is running, or aurora service is running, but not both
#before(:each) do
    $scheduler_service = '$aurora_master' #
  #end

context 'with master => true' do
  let(:facts) {
    { :ensure => 'running',
      :enable  => '$aurora::params::enable',
      :hasstatus => 'true',
      :hasrestart => 'true',
      :require  => 'Package[aurora-scheduler]',
      :provider  => '$provider',
      } }
  ####


# the test below probably has syntax errors
describe 'aurora::service' do
  it 'aurora_scheduler_service' do
    instance = aurora__service.new(:some_object)
    expect(instance).to be_running

    scheduler_pkg = aurora.new(package('aurora-scheduler'))
    expect(scheduler_pkg).to be_required # is this function

    #expect not()#subscribe) file(default/thermos)
  end
end

## cases below require that aurora::master is true
describe 'service(aurora-scheduler)'
  let(:facts) { { :osfamily => 'ubuntu' } }

it do
   should be_running.under('upstart')
  should_not be_running.under('undef')
end

describe 'service(aurora-scheduler)'
let(:facts) { { :osfamily => 'default' } }
it do
   should be_running.under('undef')
  should_not be_running.under('upstart')
end
#######
  context 'with master => true' do
    let(:params) { {:master => true} }

    it do
      should include('aurora::scheduler')
    end
  end

  context 'with master => default' do
    let(:params) { {:master => default} }

    it do
      should include('aurora::executor')
    end
  end
end
