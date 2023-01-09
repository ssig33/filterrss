# frozen_string_literal: true

require 'bundler'
Bundler.setup

require 'sinatra'
require 'rexml/document'
require 'sinatra/reloader' if development?
require 'rest-client'
require 'builder'

get '/' do
  haml :index
end

get '/rss' do
  url = params[:url]
  xml = RestClient.get(url).body

  includes = params[:includes].to_s.split(',')
  excludes = params[:excludes].to_s.split(',')

  rss = REXML::Document.new(xml)

  # doc.channel

  content_type 'application/rss+xml'

  output = ::Builder::XmlMarkup.new(indent: 2)
  output.instruct!

  output.rss(version: '2.0') do
    output.channel do
      output.title rss.elements['rss/channel/title'].text
      output.link rss.elements['rss/channel/link'].text
      output.description rss.elements['rss/channel/description'].text

      rss.elements.each('rss/channel/item') do |item|
        text = item.to_s
        next if includes.count.positive? && includes.none? { text.match(_1) }
        next if excludes.count.positive? && excludes.any? { text.match(_1) }

        output.item do
          output.title item.elements['title'].text
          output.link item.elements['link'].text
          output.description item.elements['description'].text
        end
      end
    end
  end

  output.target!
rescue
  "error: Please report this issue to mail@ssig33.com. If you think this is a bug."
end
