$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
unless defined? JRUBY_VERSION
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'rspec'
require 'active_record'
require 'action_view'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_controller/test_case'
require 'action_dispatch'
require 'rspec-hpricot-matchers'
require 'rails_paginate'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include(HpricotSpec::Matchers)
  
  def action_view
    x = ActionView::Base.new
    x.controller = action_controller
    x.stub!(:url_for).and_return do |*args|
      options = args.extract_options!
      "?page=#{options[:page]}"
    end
    x
  end

  def action_controller
    ActionController::Base.new
  end

end
