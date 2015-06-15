require 'spec_helper_acceptance'
require 'puppet'
require 'puppet/util/package'

# puppet-aurora/spec/acceptance/simple_spec.rb
# checks that /etc exists 

#describe 'beaker_test' do 
# describe file('etc/puppet/modules/test/spec/acceptance/simple_spec2') do
#       it{ should be_file }
#       # it { should be_owned_by 'root' }
#       # it { should be_mode 644 }
#      end  

describe 'localhost' do
  describe file('/etc/passwd') do
    it { should be_file }
  end
end

describe 'puppet_dir_exists' do
  describe file('/etc/puppet') do
    it { should be_directory }
  end
end

#describe 'acceptance_test_exists_rb' do
#  describe file('etc/puppet/modules/test/spec/acceptance/simple_spec2.rb') do
#    it { should be_file }
#  end
#end

describe 'manifest_dir_exists' do
  describe file('/etc/puppet/modules') do
    it { should be_directory }
  end
end

describe 'aurora_scheduler_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/scheduler.pp') do
    it { should be_file }
  end
end

