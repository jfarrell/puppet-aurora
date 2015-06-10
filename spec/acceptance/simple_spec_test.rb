
# puppet-aurora/spec/acceptance/simple_spec_test.rb
# checks that /etc exists 
require 'spec_helper'
require 'spec_helper_acceptance'

describe file('/etc/puppet-aurora/spec/acceptance/nodesets/hosts2.yml') do


        it { should be_file }
       # it { should be_owned_by 'root' }
       # it { should be_mode 644 }
      end
