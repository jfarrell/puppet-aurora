require 'spec_helper'

describe 'aurora' do

  context '::osfamily = > Debian'
  let(:facts) { { :osfamily => 'Debian'} }

    it { should contain_class('aurora::repo') }
    it { should contain_class('aurora::install') }
    it { should contain_class('aurora::service') }

    it do
      expect {
        should include_class('aurora::params')
      }
    end

    context '::osfamily => not Debian'
    let(:facts) { { :osfamily => nil }} #is this correct syntax
    it do
      expect {
        should include_class('aurora::params')
      }.to raise_error(Puppet::Error, /osfamily not supported or dependent classes have error:/)
    end
  end 
