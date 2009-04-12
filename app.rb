require 'rubygems'
require 'sinatra'
require 'rdiscount'

class Item
  attr_reader :name, :icon, :text
  def initialize(name, icon, text=nil)
    @name = name
    @icon = icon
    @text = text
  end

  def to_html
    RDiscount.new(text || 'Hello').to_html
  end
end

def items
   [
    Item.new('blog', 'blog.png', 'Check out his [Blog](http://blog.blindgaenger.net/ "blindgaenger\'s blog - when you don\'t know where you @") about software development and self-evaluation.'),
    Item.new('soup', 'soup.png', 'Everything else ends up in a [Soup](http://blindgaenger.soup.io/ "Taste the soup?") ... Yummy!'),
    Item.new('facebook', 'facebook.png', 'I know how to use [Facebook](http://www.facebook.com/ "Book of faces.") and if you\'re a kind person I\'ll add you.'),

    #Item.new('GPS', 'gps.png'),
    #Item.new('Profile', 'profile.png'),
    #Item.new('Mail', 'mail.png'),
    #Item.new('Development', 'development.png'),
    #Item.new('Music', 'music.png'),
  ]
end

get '/about' do
  @items = items
  haml :about
end

get '/' do
  @items = items
  haml :index
end

get '/:style.css' do
  content_type 'text/css'
  sass params['style'].to_sym
end
