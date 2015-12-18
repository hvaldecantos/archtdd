if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter ['spec', 'schema']
    command_name 'Mintest'
  end
end

require 'minitest/autorun'
require './user'
require './session'
require './session_manager'
require './authorizer'
