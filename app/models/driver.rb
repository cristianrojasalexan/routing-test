class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true
  has_many :routes

  def self.without_vehicles
    Driver.where(vehicle_id: nil)
  end

  def self.with_vehicles
    Driver.where.not(vehicle_id: nil)
  end
  
  def self.with_cities
    Driver.where.not(specific_cities: nil)
  end

  def self.ids_all_drivers_order_by_cities
    drivers_with_cities = Driver.where("specific_cities IS NOT NULL").pluck(:id)
    drivers_without_cities = Driver.where("specific_cities IS NULL").pluck(:id)
    return drivers = drivers_with_cities + drivers_without_cities
  end
end
