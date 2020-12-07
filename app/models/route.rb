class Route < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true

  enum load_types: { "General": 0, "Refrigerada": 1 }
end
