class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true
  has_many :routes

  def self.ids_all_drivers_order_by_cities
    drivers_with_cities = Driver.where("specific_cities IS NOT NULL").pluck(:id)
    drivers_without_cities = Driver.where("specific_cities IS NULL").pluck(:id)
    return drivers = drivers_with_cities + drivers_without_cities
  end
end
