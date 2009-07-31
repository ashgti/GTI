require 'rubygems'
require 'spork'
require 'spec'
require 'webrat'
require "webrat/core/matchers"

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.dirname(__FILE__) + "/../config/environment"
  require 'spec'
  require 'spec/rails'
  require 'lib/rspec_merb'
  
  Spec::Runner.configure do |config|
    config.include(Webrat::Matchers, :type => [:controller, :helper, :view])
  end

  # DataMapper requirements
  gem 'dm-sweatshop', '0.9.11'
  require 'dm-sweatshop'
  
  Webrat.configure do |config|
    config.mode = :rails
  end

  Spec::Runner.configure do |config|
    include Webrat::Methods

    config.before(:all) do
      # DataMapper.auto_migrate!
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  Dir.glob(Rails.root.join('spec', 'fixtures', "**", "*_fix.rb")) do |t|
    require t if File.exist? t
  end
end
