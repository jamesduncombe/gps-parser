#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new :test do |t|
  t.pattern = 'spec/lib/*_spec.rb'
  t.rspec_opts = ['--backtrace --color']
end

task :default => :test