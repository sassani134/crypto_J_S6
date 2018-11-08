require 'rails_helper'

RSpec.describe Money, type: :model do
  context 'creation of money' do
    it "when only price" do
      money = Money.new(price: 'Test').save
      expect(money).to eq(false)
    end

    it "when name blank" do
      money = Money.new(name:'      ', price: 'Test').save
      expect(money).to eq(false)
    end

    it "when name already present" do
      money2 = Money.new(name:'Toto', price: 'Test').save
      money = Money.new(name:'Toto', price: 'Test').save
      expect(money).to eq(false)
    end

    it "when only name" do
      money = Money.new(name: 'Toto').save
      expect(money).to eq(true)
    end

    it "when all filled" do
      money = Money.new(name:'Toto', price: 'Test').save
      expect(money).to eq(true)
    end
  end
end
