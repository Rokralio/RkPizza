# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_12_02_030910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bases', force: :cascade do |t|
    t.string('name')
    t.decimal('price')
    t.text('description')
    t.string('image_url')
    t.datetime('created_at', null: false)
    t.datetime('updated_at', null: false)
  end

  create_table 'ingredients', force: :cascade do |t|
    t.string('name')
    t.decimal('price')
    t.string('category')
    t.string('image_url')
    t.datetime('created_at', null: false)
    t.datetime('updated_at', null: false)
  end

  create_table 'orders', force: :cascade do |t|
    t.integer('table_number')
    t.decimal('total_price')
    t.integer('status')
    t.datetime('created_at', null: false)
    t.datetime('updated_at', null: false)
  end

  create_table 'pizza_ingredients', force: :cascade do |t|
    t.bigint('pizza_id', null: false)
    t.bigint('ingredient_id', null: false)
    t.datetime('created_at', null: false)
    t.datetime('updated_at', null: false)
    t.index(['ingredient_id'], name: 'index_pizza_ingredients_on_ingredient_id')
    t.index(['pizza_id'], name: 'index_pizza_ingredients_on_pizza_id')
  end

  create_table 'pizzas', force: :cascade do |t|
    t.string('name')
    t.bigint('base_id', null: false)
    t.datetime('created_at', null: false)
    t.datetime('updated_at', null: false)
    t.index(['base_id'], name: 'index_pizzas_on_base_id')
  end

  add_foreign_key 'pizza_ingredients', 'ingredients'
  add_foreign_key 'pizza_ingredients', 'pizzas'
  add_foreign_key 'pizzas', 'bases', column: 'base_id'
end
