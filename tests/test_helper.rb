ENV['APP_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.setup

require 'minitest/autorun'
require 'minitest/stub_any_instance'
require 'minitest/autorun'
require 'minitest/around/spec'
require 'webmock/minitest'
require 'rack/test'

WebMock.disable_net_connect!

require_relative '../app'

class MiniTest::Test
  include Rack::Test::Methods
  extend MiniTest::Spec::DSL

  def app
    Sinatra::Application
  end
end

