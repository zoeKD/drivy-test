require "json"
require "date"
require_relative "car"
require_relative "rental"

# deserialization of data.json
filepath = "data.json"
deserialized_data = JSON.parse(open(filepath).read)

cars = []
deserialized_data["cars"].each do |car|
  cars << Car.new(id: car["id"], price_per_day: car["price_per_day"], price_per_km: car["price_per_km"])
end

rentals = []
deserialized_data["rentals"].each do |rental|
  rental_car = cars.find { |car| car.id == rental["car_id"] }
  start_date = Date.parse(rental["start_date"])
  end_date = Date.parse(rental["end_date"])
  rentals << Rental.new(id: rental["id"],
                        car: rental_car,
                        start_date: start_date,
                        end_date: end_date,
                        distance: rental["distance"])
end

# computed rental prices
all_rental_prices = []
rentals.each do |rental|
  rental_commission = { insurance_fee: rental.commission.insurance_fee,
                        assistance_fee: rental.commission.assistance_fee,
                        drivy_fee: rental.commission.drivy_fee }
  all_rental_prices << { id: rental.id, price: rental.price, commission: rental_commission }
end

# serialized into output2.json
filepath = "output2.json"
rentals_prices = { rentals: all_rental_prices }

File.open(filepath, "wb") do |file|
  json_data = JSON.pretty_generate(rentals_prices)
  file.write(json_data + "\n")
end
