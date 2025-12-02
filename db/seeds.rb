# frozen_string_literal: true

puts '--- Sembrando Bases ---'
Base.find_or_create_by!(name: 'Masa Clásica') do |b|
  b.price = 5.00
  b.description = 'Nuestra masa tradicional, ni gruesa ni fina.'
  b.image_url = 'base_classic.png'
end

Base.find_or_create_by!(name: 'Masa Fina Integral') do |b|
  b.price = 6.50
  b.description = 'Opción ligera y saludable con harina integral.'
  b.image_url = 'base_thin.png'
end

puts '--- Sembrando Ingredientes ---'
Ingredient.find_or_create_by!(name: 'Salsa de Tomate') do |i|
  i.price = 0.00 # Base
  i.category = 'base'
  i.image_url = 'topping_tomato.png'
end

Ingredient.find_or_create_by!(name: 'Queso Mozzarella') do |i|
  i.price = 1.50
  i.category = 'queso'
  i.image_url = 'topping_cheese.png'
end

Ingredient.find_or_create_by!(name: 'Pepperoni') do |i|
  i.price = 2.00
  i.category = 'carne'
  i.image_url = 'topping_pepperoni.png'
end

Ingredient.find_or_create_by!(name: 'Champiñones') do |i|
  i.price = 1.00
  i.category = 'vegetal'
  i.image_url = 'topping_mushrooms.png'
end

puts 'Datos iniciales (Bases e Ingredientes) sembrados.'
