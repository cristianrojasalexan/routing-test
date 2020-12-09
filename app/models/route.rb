class Route < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true

  enum load_types: { "General": 0, "Refrigerada": 1 }

  def self.unassigned_routes
    Route.where(driver_id: nil, vehicle: nil)
  end

  def self.get_drivers_with_a_route
    Route.select("driver_id").group(:driver_id).having("count(driver_id) = 1").pluck(:driver_id)
  end
end
