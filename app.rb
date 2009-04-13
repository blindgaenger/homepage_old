require 'rubygems'
require 'sinatra'
require 'rdiscount'
require 'yaml'

helpers do
  def markdown(text)
    RDiscount.new(text).to_html
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
