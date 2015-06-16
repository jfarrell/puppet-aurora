require 'spec_helper'
# tests that the ensure_bool functions will convert strings 'true' || 'yes' to boolean true, and
#  convert strings 'false' || 'no' to boolean false,
#  which handles issue when hiera converts boolean values to strings

describe 'ensure_bool' do
  context 'when boolean given should be evaluated as true' do
    ['true', true].each do |input|
      it { should run.with_params(input).and_return(true) }
    end
  end

  context 'when boolean given should be evaluated as false' do
    ['false', false].each do |input|
      it { should run.with_params(input).and_return(false) }
    end
  end

  context 'when boolean given would be evaluated as true if using str2bool function' do
    %w(t y 1 yes).each do |input|
      it { should run.with_params(input).and_raise_error(Puppet::ParseError, /Unknown type of boolean given/) }
    end
  end

  context 'when boolean given would be evaluated as false if using str2bool function' do
    %w(f n 0 no).each do |input|
      it { should run.with_params(input).and_raise_error(Puppet::ParseError, /Unknown type of boolean given/) }
    end
  end

  context 'when input is numeric' do
    [5, 1, 0].each do |input|
      it { should run.with_params(input).and_raise_error(Puppet::ParseError, /Requires String or Boolean as input/) }
    end
  end

  context 'when input cannot be evaluated as boolean, even after converting to string' do
    %w(undef undefined).each do |undef_input|
      it { should run.with_params(undef_input).and_raise_error(Puppet::ParseError,  /Undefined/) }
    end
    it { should run.with_params('').and_raise_error(Puppet::ParseError, /empty string/) }
    it { should run.with_params('foo').and_raise_error(Puppet::ParseError, /Unknown type of boolean given/) }
  end
end
