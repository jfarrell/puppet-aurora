
# puppet-aurora/spec/acceptance/simple_spec_test.rb
# checks that /etc exists 
require 'spec_helper'

describe file('/etc/puppet-aurora/spec/acceptance/hosts.yaml') do
        it { should be_file }
       # it { should be_owned_by 'root' }
       # it { should be_mode 644 }
      end