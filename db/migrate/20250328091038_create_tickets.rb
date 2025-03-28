class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :ticket_type, null: false
      t.decimal :price, null: false, precision: 8, scale: 2
      t.integer :quantity_available, null: false

      t.timestamps
    end
  end
end
