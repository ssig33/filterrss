# frozen_string_literal: true

require './tests/test_helper'

class RssTest < Minitest::Test
  around do |test|
    RssParser.stub_any_instance(:title, 'title') do
      RssParser.stub_any_instance(:link, 'link') do
        RssParser.stub_any_instance(:description, 'description') do
          item1 = Struct.new(:title, :link, :description).new('title', 'http://link1', 'description')
          item2 = Struct.new(:title, :link, :description).new('ng', 'http://link2', 'description')
          item3 = Struct.new(:title, :link, :description).new('title', 'http://link2', 'ok')
          RssParser.stub_any_instance(:items, [item1, item2, item3]) do
            test.call
          end
        end
      end
    end
  end

  describe 'GET /rss' do
    it 'should be successful' do
      stub_request(:get, 'https://example.com/feed.xml').to_return(status: 200, body: '<xml></xml>', headers: {})

      get '/rss?url=https://example.com/feed.xml'
      assert last_response.ok?
    end

    describe '&includes=ok' do
      it 'should be response only item3' do
        stub_request(:get, 'https://example.com/feed.xml').to_return(status: 200, body: '<xml></xml>', headers: {})

        get '/rss?url=https://example.com/feed.xml&includes=ok'
        assert last_response.ok?
        parsed = RSS::Parser.parse(last_response.body, false)

        assert_equal 1, parsed.items.count
        assert_equal 'title', parsed.items[0].title
        assert_equal 'http://link2', parsed.items[0].link
        assert_equal 'ok', parsed.items[0].description
      end
    end
    
    describe '&excludes=ng' do
      it 'should be response only item1 and item3' do
        stub_request(:get, 'https://example.com/feed.xml').to_return(status: 200, body: '<xml></xml>', headers: {})

        get '/rss?url=https://example.com/feed.xml&excludes=ng'
        assert last_response.ok?
        parsed = RSS::Parser.parse(last_response.body, false)

        assert_equal 2, parsed.items.count
        assert_equal 'title', parsed.items[0].title
        assert_equal 'http://link1', parsed.items[0].link
        assert_equal 'description', parsed.items[0].description
        assert_equal 'title', parsed.items[1].title
        assert_equal 'http://link2', parsed.items[1].link
        assert_equal 'ok', parsed.items[1].description
      end
    end
  end
end
