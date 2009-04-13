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
  items = YAML.load(File.read('content.yml'))
  @texts = items.select{|i| i.is_a? String}
  @items = items.reject{|i| i.is_a? String}
  haml :index
end

get '/stylesheets/:style.css' do
  content_type 'text/css'
  sass params['style'].to_sym
end
