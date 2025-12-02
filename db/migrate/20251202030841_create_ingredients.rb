class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :price
      t.string :category
      t.string :image_url

      t.timestamps
    end
  end
end
