# frozen_string_literal: true

puts '--- Limpiando Ingredientes y Bases (opcional, si quieres reiniciar todo) ---'
# Base.destroy_all
# Ingredient.destroy_all

puts '--- Sembrando Bases (PRECIOS ACTUALIZADOS) ---'
Base.find_or_create_by!(name: 'Masa Clásica') do |b|
  b.price = 1.00
  b.description = 'Nuestra masa tradicional, ni gruesa ni fina.'
  b.image_url = 'base_classic.png'
end

Base.find_or_create_by!(name: 'Masa Fina Integral') do |b|
  b.price = 2.50
  b.description = 'Opción ligera y saludable con harina integral.'
  b.image_url = 'base_thin.png'
end

puts '--- Sembrando Ingredientes (VERIFICADOS) ---'

# Ingredientes Base y Quesos (existentes)
Ingredient.find_or_create_by!(name: 'Salsa de Tomate') do |i|
  i.price = 0.00
  i.category = 'sauce'
  i.image_url = 'topping_tomato.png'
end

Ingredient.find_or_create_by!(name: 'Queso Mozzarella') do |i|
  i.price = 1.50
  i.category = 'cheese'
  i.image_url = 'topping_cheese.png'
end

# Ingredientes de Carnes y Vegetales (existentes)
Ingredient.find_or_create_by!(name: 'Pepperoni') do |i|
  i.price = 2.00
  i.category = 'meat'
  i.image_url = 'topping_pepperoni.png'
end

Ingredient.find_or_create_by!(name: 'Champiñones') do |i|
  i.price = 1.00
  i.category = 'vegetable'
  i.image_url = 'topping_mushrooms.png'
end

# --- NUEVOS INGREDIENTES AÑADIDOS ---

# Nuevas Carnes
Ingredient.find_or_create_by!(name: 'Jamón') do |ing|
  ing.price = 2.00
  ing.category = 'meat'
  ing.image_url = 'topping_ham.png'
end

Ingredient.find_or_create_by!(name: 'Tocino') do |ing|
  ing.price = 2.50
  ing.category = 'meat'
  ing.image_url = 'topping_bacon.png'
end

Ingredient.find_or_create_by!(name: 'Carne Molida') do |ing|
  ing.price = 3.00
  ing.category = 'meat'
  ing.image_url = 'topping_beef.png'
end

# Nuevos Vegetales / Frutas
Ingredient.find_or_create_by!(name: 'Aceitunas') do |ing|
  ing.price = 1.00
  ing.category = 'vegetable'
  ing.image_url = 'topping_olives.png'
end

Ingredient.find_or_create_by!(name: 'Piña') do |ing|
  ing.price = 1.50
  ing.category = 'fruit'
  ing.image_url = 'topping_pineapple.png'
end

Ingredient.find_or_create_by!(name: 'Durazno') do |ing|
  ing.price = 1.80
  ing.category = 'fruit'
  ing.image_url = 'topping_peach.png'
end

puts 'Datos iniciales (Bases e Ingredientes) sembrados.'
