# frozen_string_literal: true

class PizzaBuilderController < ApplicationController
  def index
    # Carga todas las bases y los ingredientes de la base de datos
    @bases = Base.all
    @ingredients = Ingredient.all

    # Exponemos los nombres de los tamaños de pizza (keys del enum) al frontend
    # Ejemplo: ["pequeña", "mediana", "grande", "familiar"]
    @pizza_sizes = Pizza.sizes.keys
  end
end
