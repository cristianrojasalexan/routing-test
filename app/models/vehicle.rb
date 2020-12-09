class Vehicle < ApplicationRecord
  belongs_to :driver, optional: true
  has_many :routes

  enum load_types: { "General": 0, "Refrigerada": 1 }

  def self.unassigned_vehicles
    assigned_vehicles = Route.where.not(vehicle_id: nil).pluck(:vehicle_id)
    Vehicle.where.not(id: assigned_vehicles)
  end
end
