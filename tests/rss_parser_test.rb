# frozen_string_literal: true

require './tests/test_helper'

class RssParserTest < MiniTest::Test
  describe '#title' do
    it 'should return title' do
      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><title>title</title></rss>'
      parser = RssParser.new(xml)
      assert_equal 'title', parser.title

      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><title>title</title></channel></rss>'
      parser = RssParser.new(xml)
      assert_equal 'title', parser.title
    end
  end

  describe '#link' do
    it 'should return link' do
      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><link>link</link></rss>'
      parser = RssParser.new(xml)
      assert_equal 'link', parser.link

      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><link>link</link></channel></rss>'
      parser = RssParser.new(xml)
      assert_equal 'link', parser.link
    end
  end

  describe '#description' do
    it 'should return description' do
      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><description>description</description></rss>'
      parser = RssParser.new(xml)
      assert_equal 'description', parser.description

      xml = '<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"><channel><description>description</description></channel></rss>'
      parser = RssParser.new(xml)
      assert_equal 'description', parser.description
    end
  end

  describe '#items' do
    it 'should return items' do
      xml = '<rss><channel><item><title>title</title><link>link</link><description>description</description></item></channel></rss>'
      parser = RssParser.new(xml)
      assert_equal 'title', parser.items[0].title
      assert_equal 'link', parser.items[0].link
      assert_equal 'description', parser.items[0].description
    end
  end

end
