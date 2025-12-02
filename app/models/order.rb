# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :pizzas, dependent: :destroy # Un pedido tiene muchas pizzas, si se borra el pedido, se borran las pizzas

  # Definición del estado del pedido
  enum status: { pending: 0, in_progress: 1, completed: 2 }, _default: :pending

  # Validaciones
  validates :table_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
