require 'nokogiri'
require 'open-uri'

class Scrapp_money
	# frozen_string_literal: true
  attr_accessor :hash, :name

  def initialize(name_money="" ,url = "https://coinmarketcap.com/all/views/all/")
    @url = url
    @page = Nokogiri::HTML(open(@url))
    @hash = {}
    @name = []
    @money_name= name_money
    # on récupère le texte contenu dans la classe currency-name-container link-secondary
  end

  # Récupère un tableau contenant le nom des monnaies
  def get_name_money 
    @name=@page.xpath('//a[@class="currency-name-container link-secondary"]').map { |link| link.text }
  end

  # Récupère un tableau contenant le prix des monnaies
  def get_price_money
    array = @page.css('.price').map { |link| link.text }
  end

  #cree un hash avec les tableaux name et price
  def create_hash_name_price (name,price)
    array_of_money = name.zip(price).map{|name, price| {name: name, price: price}}
    array_of_money.select {|hash| hash[:name] == @money_name}[0]
  end

# perform les fonctions
  def perform
    create_hash_name_price(get_name_money,get_price_money)
  end

  def save 
    @hash = perform
    if @hash
      money = Money.find_by name: @hash[:name]
      if money
        money.update_attributes(price: @hash[:price])
      else
        money = Money.create!(hash)     
      end
    else
      return false
    end
  end

end