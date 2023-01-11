require './tests/test_helper'

class WelcomeTest < MiniTest::Test
  describe "GET /" do
    it "should be successful" do
      get '/'
      assert last_response.ok?
    end
  end
end
