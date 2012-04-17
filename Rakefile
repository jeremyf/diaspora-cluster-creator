#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'
require 'cucumber/rake/task'

namespace 'test' do |ns|
  test_files             = FileList['spec/**/*_spec.rb']
  integration_test_files = FileList['spec/**/*_integration_spec.rb']
  unit_test_files        = test_files - integration_test_files

  desc "Run unit tests"
  Rake::TestTask.new('unit') do |t|
    t.libs.push "lib"
    t.test_files = unit_test_files
    t.verbose = true
  end

  desc "Run integration tests"
  Rake::TestTask.new('integration') do |t|
    t.libs.push "lib"
    t.test_files = integration_test_files
    t.verbose = true
  end
  
  desc "Run acceptance tests"
  Cucumber::Rake::Task.new('acceptance') do |t|
    t.fork = true
  end

  desc "Run travis tests"
  Cucumber::Rake::Task.new('travis-acceptance') do |t|
    t.fork = true
    t.cucumber_opts = %(--tags ~@skip_travis)
  end
end

task('test').clear
desc "Run all tests"
task 'test' => %w[test:unit test:integration]

task 'default' => %w[test:unit test:integration test:acceptance]

task 'travis' => %w[test:unit test:integration test:travis-acceptance]