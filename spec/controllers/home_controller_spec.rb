require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

	context "Get #index" do
		it 'when alone ' do 
			get :index
			expect(response).to be_successful
      expect(response.body).to include 'Entre leurs nom ci dessous !'
      expect(response.body).to include 'Confirme ici!'
    end

    it 'when entered with correct parameters' do 
      get :index, params: { anything: { name: "TRON" }}
      expect(response.body).to include 'Voici le cours que tu as demandé'
      expect(response.body).to include 'La monnaie TRON a pour prix'
      expect(response.body).to have_link('Retour au choix de la monnaie')
    end

    it 'when entry already in database and entered with correct parameters' do 
      money = Money.new(name: 'TRON').save
      url = "https://coinmarketcap.com/all/views/all/"
      hash = Scrapp_money.new( url , "TRON").perform
      get :index, params: { anything: { name: "TRON" }}
      expect(response.body).to include 'Voici le cours que tu as demandé' 
      expect(response.body).to include 'La monnaie TRON a pour prix '+hash[:price]
      expect(response.body).to have_link('Retour au choix de la monnaie')
    end

    it 'when entered with inexistant money' do
      get :index, params: { anything: { name: "toto" }}
      expect(flash[:error]).to be_present
			expect(response).to redirect_to '/'
    end

    it 'when entered with lowercase money' do
      get :index, params: { anything: { name: "tron" }}
      expect(flash[:error]).to be_present
			expect(response).to redirect_to '/'
    end
  end
end
