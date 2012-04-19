if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-gem-adapter'
  SimpleCov.start 'gem'
end

gem 'minitest' # demand gem version
require 'minitest/spec'
require 'minitest/autorun'
require 'ostruct'
require 'factory_girl'
$: << File.expand_path('../lib/diaspora-cluster-creator', File.dirname(__FILE__))
require 'diaspora-cluster-creator'
require_relative 'factories'

# Cheating a bit to help tests be a bit more readable
include Diaspora::Cluster::Creator

class MiniTest::Unit::TestCase
  def with_loaded_dice(roll, object)
    loaded_dice = MiniTest::Mock.new
    loaded_dice.expect(:roll, roll)
    object.dice = loaded_dice
    yield
    loaded_dice.verify
  end
end
