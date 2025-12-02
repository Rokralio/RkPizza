# frozen_string_literal: true

class Pizza < ApplicationRecord
  belongs_to :order      # Una pizza pertenece a un pedido
  belongs_to :base       # Una pizza usa una base

  # Configuración de muchos a muchos con Ingredient
  has_many :pizza_ingredients, dependent: :destroy
  has_many :ingredients, through: :pizza_ingredients

  # Definición del enum para los tamaños
  enum size: { pequeña: 0, mediana: 1, grande: 2, familiar: 3 }

  # Validaciones
  validates :name, presence: true
  validates :size, presence: true
end
