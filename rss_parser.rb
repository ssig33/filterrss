require 'rexml/document'

class RssParser
  def initialize xml
    @rss = REXML::Document.new xml
  end

  def title
    @rss.elements['rss/channel/title'].text
  end

  def link
    @rss.elements['rss/channel/link'].text
  end

  def description
    @rss.elements['rss/channel/description'].text
  end

  def items
    array = []
    @rss.elements.each('rss/channel/item') do |item|
      i = Struct.new(:title, :link, :description, :to_s).new
      i.title = item.elements['title'].text
      i.link = item.elements['link'].text
      i.description = item.elements['description'].text
      i.to_s = item.to_s
      array.push i
    end
    array
  end
end
