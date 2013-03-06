#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'CrumbTrail'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# NOTE rake spec
require 'rspec/core/rake_task'
task :noop do; end
task :default => :spec

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => :noop)

namespace :spec do
  def types
    dirs = Dir['./spec/**/*_spec.rb'].map { |f| f.sub(/^\.\/(spec\/\w+)\/.*/, '\\1') }.uniq
    Hash[dirs.map { |d| [d.split('/').last, d] }]
  end

  types.each do |type, dir|
    desc "Run the code examples in #{dir}"
    RSpec::Core::RakeTask.new(type => :noop) do |t|
      t.pattern = "./#{dir}/**/*_spec.rb"
    end
  end
end




Bundler::GemHelper.install_tasks

