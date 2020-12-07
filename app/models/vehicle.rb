class Vehicle < ApplicationRecord
  belongs_to :driver, optional: true
  has_many :routes
end
