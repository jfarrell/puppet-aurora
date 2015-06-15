#tests config of docker container launched using beaker
require 'spec_helper'

# check that files copied over to /etc/puppet/modules/test in docker container 
describe 'docker_container_config' do
  describe file('/etc/puppet/modules/test') do
    it { should be_directory }
  end
end

# check host config

  # check OS is ubuntu

  # check ubuntu version
  
  # check roles 

  # check ubuntu image is trusty

  # check platform

# check docker config
  # check that it is a docker container (check hypervisor) 
#  describe docker_image('busybox:latest') do
#  it { should exist }
#end
#
# describe docker_image('busybox:latest') do
#  it { should exist }
#  its(['Architecture']) { should eq 'amd64' }
#end
 
describe host('ubuntu-14-04') do
  its(:ipaddress) { should eq '172.17.0.104' }
end
  # check container name 

    # does container have name/what is name

  # check config type == foss

  # check log_level ==verbose
  
  # check container is not local!

# check ssh 
  # check password should be root
  
  # check auth_method

  # check ip_address ssh to 

# check docker commands executed
# important 
  # check software-properties-commons installed 
  # check ppa:openjdk-r/ppa repo added
  # check openjdk-8-r-headless installed
