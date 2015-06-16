#
# ensure_bool.rb
#

module Puppet::Parser::Functions
  newfunction(:ensure_bool, type: :rvalue, doc: <<-EOS
    Converts a string with correct boolean value to a boolean type. Converts the values:
      'false' to false
      'true' to true
    Requires a single boolean or string as an input.
    EOS
             ) do |arguments|
    fail(Puppet::ParseError, 'ensure_bool(): Wrong number of arguments ' \
      "given (#{arguments.size} for 1)") if arguments.size != 1

    string = arguments[0]

    # If string is already Boolean, return it
    return string if !!string == string

    unless string.is_a?(String)
      fail(Puppet::ParseError, 'ensure_bool(): Requires String or Boolean as input')
    end

    result = case string
      # The following  cases convert a string with value 'true' to be boolean with value true, and
      # convert a string with value'false' to be boolean with value false

      # An empty string should return an error
      when /^$/, '' then fail(Puppet::ParseError, 'ensure_bool(): an empty string is not a valid boolean')
      when /^(true)$/  then true
      when /^(false)$/  then false

      when /^(undef|undefined)$/ then fail(Puppet::ParseError, 'ensure_bool(): Undefined argument given')
      else
        fail(Puppet::ParseError, 'ensure_bool(): Unknown type of boolean given')
    end

    return result
  end
      end
