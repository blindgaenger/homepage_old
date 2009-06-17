require 'rubygems'
require 'sinatra'
require 'yaml'

helpers do
  def to_html(item)
    link = %Q[<a href="#{item['link']}" title="#{item['desc']}">#{item['name']}</a>]
    item['text'].gsub("LINK", link)
  end
  
  def memcache(&block)
    return yield if development?
  
    @@cache ||= {}
    path = request.path_info.to_s || "index"
    content = @@cache[path]
    if content.nil?
      puts "CACHED: #{request.path_info}"
      content = @@cache[path] = yield
    end
    etag path
    content
  end
end

get '/' do
  memcache do
    @items = YAML.load(File.read('content.yml'))
    haml :index
  end
end

get '/stylesheets/:style.css' do
  content_type 'text/css'
  memcache do
    sass params['style'].to_sym
  end
end

