class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :table_number
      t.decimal :total_price
      t.integer :status

      t.timestamps
    end
  end
end
