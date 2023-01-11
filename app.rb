# frozen_string_literal: true

require 'bundler'
Bundler.setup

require 'sinatra'
require 'sinatra/reloader' if development?
require 'rest-client'
require 'builder'
require './rss_parser'

configure do
  also_reload './rss_parser.rb' if development?
end

get '/' do
  haml :index
end

get '/rss' do
  url = params[:url]
  xml = RestClient.get(url).body

  includes = params[:includes].to_s.split(',')
  excludes = params[:excludes].to_s.split(',')

  rss = RssParser.new(xml)

  content_type 'application/rss+xml'

  output = ::Builder::XmlMarkup.new(indent: 2)
  output.instruct!

  output.rss(version: '2.0') do
    output.channel do
      output.title rss.title
      output.link rss.link
      output.description rss.description

      rss.items.each do |item|
        next if includes.count.positive? && includes.none? { item.to_s.match(_1) }
        next if excludes.count.positive? && excludes.any? { item.to_s.match(_1) }
        output.item do
          output.title item.title
          output.link item.link
          output.description item.description
        end
      end
    end
  end

  output.target!
rescue
  "error: Please report this issue to mail@ssig33.com. If you think this is a bug."
end
