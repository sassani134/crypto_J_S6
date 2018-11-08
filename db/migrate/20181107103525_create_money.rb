class CreateMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :money do |t|
      t.string :name, unique: true
      t.string :price
      t.timestamps
    end
  end
end
