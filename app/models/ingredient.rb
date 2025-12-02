# frozen_string_literal: true

class Ingredient < ApplicationRecord
  # Configuración de muchos a muchos con Pizza
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizzas, through: :pizza_ingredients

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
