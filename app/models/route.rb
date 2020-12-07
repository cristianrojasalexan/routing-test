class Route < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true
end
