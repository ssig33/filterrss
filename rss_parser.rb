require 'rexml/document'
require 'rss'

class RssParser
  def initialize xml
    @rss = RSS::Parser.parse(xml, false)
  end

  def title
    @rss.channel.title
  end

  def link
    @rss.channel.link
  end

  def description
    @rss.channel.description
  end

  def items
    @rss.items.map do |item|
      s = Struct.new(:title, :link, :description, :to_s).new
      s.title = item.title
      s.link = item.link
      s.description = item.description
      s.to_s = item.to_s
      s
    end
  end
end
