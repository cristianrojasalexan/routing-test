class AddDriverReferencesToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :driver, null: true, foreign_key: true
  end
end
