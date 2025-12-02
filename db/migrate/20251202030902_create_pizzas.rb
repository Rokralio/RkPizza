# frozen_string_literal: true

class CreatePizzas < ActiveRecord::Migration[7.2]
  def change
    create_table(:pizzas) do |t|
      t.string(:name)
      t.references(:base, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
