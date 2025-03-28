class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :total_price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
