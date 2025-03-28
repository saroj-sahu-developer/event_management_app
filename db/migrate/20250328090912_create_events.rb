class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :date, null: false
      t.string :venue, null: false
      t.references :organizer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
