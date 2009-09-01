require 'rubygems'
require 'sinatra'
require 'yaml'

configure do
  PROFILE_DIR = ENV['PROFILE'] || ARGV[0]
  if PROFILE_DIR.nil? || !File.exist?(PROFILE_DIR)
    raise "specify a valid $PROFILE environment variable or a command line argument"
  end
  set :public, File.join(PROFILE_DIR, 'public')
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
    content_file = File.join(PROFILE_DIR, 'content.yml')
    content = YAML.load(File.read(content_file))
    @config = content['config']
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
    # let's use an import statement to load the specific sass variables
    sass params['style'].to_sym, :sass => {
      :style => :compressed,
      :load_paths => [PROFILE_DIR]
    }
  end
end

