require 'rubygems'
require 'sinatra'
require 'yaml'

helpers do
  def to_html(item)
    link = %Q[<a href="#{item['link']}" title="#{item['desc']}">#{item['name']}</a>]
    item['text'].gsub("LINK", link)
  end
end

get '/' do
  @items = YAML.load(File.read('content.yml'))
  haml :index
end

get '/stylesheets/:style.css' do
  content_type 'text/css'
  sass params['style'].to_sym
end
