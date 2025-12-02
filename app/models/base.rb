# frozen_string_literal: true

class Base < ApplicationRecord
  has_many :pizzas, dependent: :destroy # Una base puede usarse en muchas pizzas

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
