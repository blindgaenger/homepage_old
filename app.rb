require 'rubygems'
require 'sinatra'


class Item
  attr_reader :name, :icon
  def initialize(name, icon)
    @name = name
    @icon = icon
  end
end

get '/about' do
  haml :about
end

get '/' do
  @items = [
    Item.new('GPS', 'com.apple.Maps.png'),
    Item.new('Profile', 'com.apple.MobileAddressBook.png'),
    Item.new('Mail', 'com.apple.mobilemail.png'),
    Item.new('Development', 'com.apple.Preferences.png'),
    Item.new('Me', 'avatar.png'),
    Item.new('Music', 'com.apple.Remote.png'),
  ]
  haml :index
end

get '/:style.css' do
  content_type 'text/css'
  sass params['style'].to_sym
end
