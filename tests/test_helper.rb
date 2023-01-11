ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.setup

require 'minitest/autorun'
require 'rack/test'

require_relative '../app'

class MiniTest::Test
  include Rack::Test::Methods
  extend MiniTest::Spec::DSL

  def app
    Sinatra::Application
  end
end

