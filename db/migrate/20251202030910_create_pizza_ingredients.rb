# frozen_string_literal: true

class CreatePizzaIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table(:pizza_ingredients) do |t|
      t.references(:pizza, null: false, foreign_key: true)
      t.references(:ingredient, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
