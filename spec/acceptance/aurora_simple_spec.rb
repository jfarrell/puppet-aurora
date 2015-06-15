# aurora_config_spec.rb
# tests basic dependencies for aurora are installed or exist
require 'spec_helper'
require 'serverspec'
require 'spec_helper_acceptance'
require 'puppet'
require 'puppet/util/package'

# check that directory /etc/puppet/modules/test exists
describe 'modules/test_dir_exists' do
  describe file('/etc/puppet/modules/test') do
    it { should be_directory }
  end
end

# check that dir /etc/puppet/modules/test/manifests exists
 describe 'manifest_dir_exists' do
  describe file('/etc/puppet/modules/test/manifests') do
    it { should be_directory }
  end
end

  ## check that all expected .pp manifest files exist 
	
  ### check that executor file (/etc/puppet/modules/test/manifests/executor.pp) exists
describe 'aurora_executor_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/executor.pp') do
    it { should be_file }
  end
end

# check that init file (/etc/puppet/modules/test/manifest/init.pp) exists
describe 'aurora_init_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/init.pp') do
    it { should be_file }
  end
end

  ### check that install file (/etc/puppet/modules/test/manifests/install.pp) exists
describe 'aurora_install_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/install.pp') do
    it { should be_file }
  end
end

  ### check that params file (/etc/puppet/modules/test/manifests/params.pp) exists
  describe 'aurora_params_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/params.pp') do
    it { should be_file }
  end
end

  ### check that repo file (/etc/puppet/modules/test/manifests/repo.pp) exists
  describe 'aurora_repo_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/repo.pp') do
    it { should be_file }
  end
end

  ### check that scheduler file (/etc/puppet/modules/test/manifests/scheduler.pp) exists
  describe 'aurora_scheduler_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/scheduler.pp') do
    it { should be_file }
  end
end

  ### check that service file (/etc/puppet/modules/test/manifests/service.pp) exists
describe 'aurora_service_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/service.pp') do
    it { should be_file }
  end
end

  ### check that slave file (/etc/puppet/modules/test/manifests/slave.pp) exists
describe 'aurora_slave_file_exists' do
  describe file('/etc/puppet/modules/test/manifests/slave.pp') do
    it { should be_file }
  end
end

#check that dir /etc/puppet/modules/test/templates exists
    describe 'template_dir_exists' do
  describe file('/etc/puppet/modules/test/templates') do
    it { should be_directory }
  end
end

  ## check that all expected .erb template files exist for aurora
   ### check that 'aurora-scheduler.erb' template file /etc/puppet/modules/test/templates/aurora-scheduler.erb exists
  describe 'aurora_schedulere_template_exists' do
  describe file('/etc/puppet/modules/test/templates/aurora-scheduler.erb') do
    it { should be_file }
  end
end
	
  ### check that 'thermos.erb' template file /etc/puppet/modules/test/templates/thermos.erb exists
  describe 'aurora_thermos_template_exists' do
   describe file('/etc/puppet/modules/test/templates/thermos.erb') do
     it { should be_file }
   end
 end

# check that aurora Puppetfile (/etc/puppet/modules/test/Puppetfile) exists
  describe 'puppetfile_exists' do
  describe file('/etc/puppet/modules/test/Puppetfile') do
    it { should be_file }
  end
 end

# check that aurora Dockerfile (/etc/puppet/modules/test/Dockerfile) exists
  describe 'dockerfile_exists' do
  describe file('/etc/puppet/modules/test/Dockerfile') do
    it { should be_file }
  end
 end

# check that other misc dependencies required for aurora setup exist
	
  ## check that metadata.json (/etc/puppet/modules/test/metadata.json) exists
   describe 'metadata_exists' do
  describe file('/etc/puppet/modules/test/metadata.json') do
    it { should be_file }
  end
 end

   ### check aurora version
   ### check dependencies
    #### check puppetlabs-stdlib version req
    #### check puppetlabs-apt version req
    #### check OS_support matches docker container OS

  ## check that .travis.yml (/etc/puppet/modules/test/.travis.yml) exists
   describe 'travis_exists' do
  describe file('/etc/puppet/modules/test/.travis.yml') do
    it { should be_file }
  end
 end

     ### check rvm
  ## check that .gitignore (/etc/puppet/modules/test/.gitignore) exists
   describe '.gitignore_exists' do
  describe file('/etc/puppet/modules/test/.gitignore') do
    it { should be_file }
  end
 end
	
  ## check that Gemfile (/etc/puppet/modules/test/Gemfile) exists
  describe 'gemfile_contents' do
  describe file('/etc/puppet/modules/test/Gemfile') do
    it { should be_file }

   ### check group :test gems
   # test 'rspec' exists between "group :test do" and "end".
       it { should contain('rspec').from(/^group :test do/).to(/^end/) }

  #### check puppet environment version (expect 3.7.0)
  # test 'rspec' exists after "group :test do".
  it { should contain('~> 3.7.0').after(/^'ENV['PUPPET_VERSION'] ||'/) }
 
  #### check rspec version < 3.2.0 (this is probably not that important to check at the moment..)
 
   ### check group :development gems
    # test 'travis' exists between "group :test do" and "end".
       it { should contain('travis').from(/^group :development do/).to(/^end/) }
    #  test 'travis-lint' exists between "group :development do" and "end".
       it { should contain('travis-lint').from(/^group :development do/).to(/^end/) }
   # test 'vagrant-wrapper' exists between "group :development do" and "end".
       it { should contain('vagrant-wrapper').from(/^group :development do/).to(/^end/) }
    # test 'guard-rake' exists between "group :development do" and "end".
       it { should contain('guard-rake').from(/^group :development do/).to(/^end/) }

  ### check group :system_tests gems
     # test 'beaker' exists between "group :system_tests do" and "end".
       it { should contain('beaker').from(/^group :system_tests do/).to(/^end/) }
     # test 'beaker-rspec' exists between "group :system_tests do" and "end".
       it { should contain('beaker-rspec').from(/^group :system_tests do/).to(/^end/) }
  end 
 end
