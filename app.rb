require 'rubygems'
require 'sinatra'
require 'yaml'

configure do
  CONTENT_DIR = ENV['CONTENT'] || ARGV[0]
  if CONTENT_DIR.nil? || !File.exist?(CONTENT_DIR)
    raise "specify a valid $CONTENT environment variable or a command line argument"
  end
  set :public, File.join(CONTENT_DIR, 'public')
end

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
    content_file = File.join(CONTENT_DIR, 'content.yml')
    content = YAML.load(File.read(content_file))
    @items = content['items']
    haml :index
  end
end

get '/commons/*' do
  path = File.join'.', unescape(request.path_info)
  pass unless File.file?(path)
  send_file path, :disposition => nil
end

get '/stylesheets/:style.css' do
  content_type 'text/css'
  memcache do
    sass params['style'].to_sym
  end
end

