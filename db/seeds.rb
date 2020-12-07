# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Driver.delete_all
puts "Destroy Conductores"
Vehicle.delete_all
puts "Destroy vehiculos"
Route.delete_all
puts "Destroy Rutas"

# Vechicles

10.times do
  vehicle = Vehicle.new(
    capacity:  rand(10..40),
    load_type: rand(0..1),
    driver_id: nil
  )
  vehicle.save!
end
puts "Vehiculos creados"

# Drivers

10.times do
  driver = Driver.new(
    name: Faker::Superhero.name,
    phone: Faker::Number.number(digits: 9),
    email: "#{Faker::Superhero.prefix}@correo.cl",
    vehicle_id: nil,
    specific_cities: nil,
    max_stops_amount: nil
  )
  driver.save!
end
5.times do
  vehicle = Vehicle.new(
    capacity:  rand(10..40),
    load_type: rand(0..1),
    driver_id: nil
  )
  vehicle.save!
  driver = Driver.new(
    name: Faker::Superhero.name,
    phone: Faker::Number.number(digits: 9),
    email: "#{Faker::Superhero.prefix}@correo.cl",
    vehicle_id: vehicle.id,
    specific_cities: "La Cisterna,San Miguel,El Bosque,San Bernardo,San Ramon",
    max_stops_amount: 5
  )
  driver.save!
  vehicle.driver_id = driver.id
  vehicle.save!
end
5.times do
  vehicle = Vehicle.new(
    capacity:  rand(10..40),
    load_type: rand(0..1),
    driver_id: nil
  )
  vehicle.save!
  driver = Driver.new(
    name: Faker::Superhero.name,
    phone: Faker::Number.number(digits: 9),
    email: "#{Faker::Superhero.prefix}@correo.cl",
    vehicle_id: vehicle.id,
    specific_cities: "Las Condes,Vitacura,Providencia,La Reina,Ñuñoa",
    max_stops_amount: 5
  )
  driver.save!
  vehicle.driver_id = driver.id
  vehicle.save!
end
puts "Conductores creados"

# Routes
10.times do
  route = Route.new(
    starts_at: DateTime.parse("12/07/2020 8:00"),
    ends_at: DateTime.parse("12/07/2020 13:00"),
    load_type: rand(0..1),
    load_sum: rand(10..40),
    cities: "La Cisterna,San Miguel,Departamental",
    stops_amount: 4,
    vehicle_id: nil,
    driver_id: nil
  )
  route.save!
end
10.times do
  route = Route.new(
    starts_at: DateTime.parse("12/07/2020 8:00"),
    ends_at: DateTime.parse("12/07/2020 13:00"),
    load_type: rand(0..1),
    load_sum: rand(10..40),
    cities: "La Pintana,San Ramon,La Granja,La Cisterna",
    stops_amount: 4,
    vehicle_id: nil,
    driver_id: nil
  )
  route.save!
end
10.times do
  route = Route.new(
    starts_at: DateTime.parse("12/07/2020 8:00"),
    ends_at: DateTime.parse("12/07/2020 13:00"),
    load_type: rand(0..1),
    load_sum: rand(10..40),
    cities: "La Cisterna,La Granja,Puente Alto, La Florida",
    stops_amount: 6,
    vehicle_id: nil,
    driver_id: nil
  )
  route.save!
end
10.times do
  route = Route.new(
    starts_at: DateTime.parse("12/07/2020 8:00"),
    ends_at: DateTime.parse("12/07/2020 13:00"),
    load_type: rand(0..1),
    load_sum: rand(10..40),
    cities: "Las Condes,Providencia,Santiago,Estacion Central",
    stops_amount: 8,
    vehicle_id: nil,
    driver_id: nil
  )
  route.save!
end
10.times do
  route = Route.new(
    starts_at: DateTime.parse("12/07/2020 13:30"),
    ends_at: DateTime.parse("12/07/2020 18:00"),
    load_type: rand(0..1),
    load_sum: rand(10..40),
    cities: "Las Condes,Providencia,Santiago,Estacion Central",
    stops_amount: 5,
    vehicle_id: nil,
    driver_id: nil
  )
  route.save!
end
puts "Rutas creadas"