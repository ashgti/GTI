# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

desc 'Default: run spec examples'
task :default => 'spec'

def ask message, default = nil
  print message 
  if default
    print "[#{default}] "
  end
  input = $stdin.gets.chomp
  default ||= input
end