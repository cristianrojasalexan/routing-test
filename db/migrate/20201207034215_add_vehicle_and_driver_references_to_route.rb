class AddVehicleAndDriverReferencesToRoute < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :vehicle, null: true, foreign_key: true
    add_reference :routes, :driver, null: true, foreign_key: true
  end
end
