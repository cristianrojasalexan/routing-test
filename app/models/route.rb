class Route < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true

  enum load_types: { "General": 0, "Refrigerada": 1 }

  def self.unassigned_routes
    Route.where(driver_id: nil, vehicle: nil)
  end

  def self.drivers_ids
    Route.all.pluck(:driver_id)
  end

  def self.drivers_with_route
    Route.where.not(driver_id: nil).pluck(:driver_id)
  end
end
