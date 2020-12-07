class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :sprecific_cities
      t.integer :max_stops_amount

      t.timestamps
    end
  end
end
