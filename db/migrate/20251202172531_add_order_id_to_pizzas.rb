# frozen_string_literal: true

class AddOrderIdToPizzas < ActiveRecord::Migration[7.2]
  def change
    add_reference(:pizzas, :order, null: false, foreign_key: true)
  end
end
