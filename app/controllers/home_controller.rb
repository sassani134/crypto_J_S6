class HomeController < ApplicationController
  def index
    @money = nil
    
    if params[:anything]
      @name = params['anything']['to']
      puts @name
      puts @name.class
      h = Scrapp_money.new(@name).save
      @money = Money.find_by name: @name
      unless @money
        redirect_to root_path, :flash => { :error => "Ta monnaie ne semble pas exister (attention, la casse est importante)" }
      end
    else
      @name_money= Scrapp_money.new.get_name_money 
    end


  end
end
