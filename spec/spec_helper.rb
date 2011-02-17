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
require 'rails_paginate'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  def action_view
    x = ActionView::Base.new
    x.controller = action_controller
    x.request = action_controller.request
    x
  end

  def action_controller
    x = DummyController.new
    x.request = test_request
    x.response = test_response
    x
  end

  def routes
    ActionDispatch::Routing::RouteSet.new.draw { root :to => "index#dummy" }
  end

  def test_request
    ActionController::TestRequest.new
  end

  def test_response
    ActionController::TestResponse.new
  end

end
