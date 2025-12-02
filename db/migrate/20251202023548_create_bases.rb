class CreateBases < ActiveRecord::Migration[7.2]
  def change
    create_table :bases do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
