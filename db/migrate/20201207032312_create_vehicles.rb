class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.float :capacity
      t.integer :load_type

      t.timestamps
    end
  end
end
