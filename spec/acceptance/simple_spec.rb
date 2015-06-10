require 'spec_helper_acceptance'
# puppet-aurora/spec/acceptance/simple_spec_test.rb
# checks that /etc exists 

describe file('/etc/puppet-aurora/spec/acceptance/nodesets/hosts2.yml') do


        it { should be_file }
       # it { should be_owned_by 'root' }
       # it { should be_mode 644 }
      end
