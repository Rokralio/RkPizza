class AddSizeToPizzas < ActiveRecord::Migration[7.2]
  def change
    add_column :pizzas, :size, :integer
  end
end
