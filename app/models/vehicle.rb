class Vehicle < ApplicationRecord
  belongs_to :driver, optional: true
  has_many :routes

  enum load_types: { "General": 0, "Refrigerada": 1 }
end
