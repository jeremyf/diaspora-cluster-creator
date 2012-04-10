gem 'minitest' # demand gem version
require 'minitest/spec'
require 'minitest/autorun'
require 'ostruct'
$: << File.expand_path('../lib/diaspora-cluster-creator', File.dirname(__FILE__))

# Cheating a bit to help tests be a bit more readable
include Diaspora::Cluster::Creator