ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'webmock'

require_relative '../app'

class MiniTest::Test
  include Rack::Test::Methods
  extend MiniTest::Spec::DSL

  def app
    Sinatra::Application
  end
end

