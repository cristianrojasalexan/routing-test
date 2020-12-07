class AddVehicleReferencesToDriver < ActiveRecord::Migration[6.0]
  def change
    add_reference :drivers, :vehicle, null: true, foreign_key: true
  end
end
