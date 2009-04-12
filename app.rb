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
    Item.new('Blog', 'avatar.png', "Check out his [Blog](http://blog.blindgaenger.net/)"),
    Item.new('GPS', 'com.apple.Maps.png'),
    Item.new('Profile', 'com.apple.MobileAddressBook.png'),
    Item.new('Mail', 'com.apple.mobilemail.png'),
    Item.new('Development', 'com.apple.Preferences.png'),
    Item.new('Music', 'com.apple.Remote.png'),
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
