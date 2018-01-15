require "json"
require "date"
require_relative "car"
require_relative "rental"
require_relative "rental_modification"

class InputOutput
  def deserialize_data(filepath)
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
                            distance: rental["distance"],
                            deductible_reduction: rental["deductible_reduction"])
    end
    rental_modifications = []
    deserialized_data["rental_modifications"].each do |modification|
      modif_rental = rentals.find { |rental| rental.id == modification["rental_id"] }
      start_date = Date.parse(modification["start_date"]) if modification["start_date"]
      end_date = Date.parse(modification["end_date"]) if modification["end_date"]
      rental_modifications << RentalModification.new(id: modification["id"],
                                                     rental: modif_rental,
                                                     start_date: start_date,
                                                     end_date: end_date,
                                                     distance: modification["distance"])
    end
    return rental_modifications
  end

  def serialize_data(filepath, content)
    File.open(filepath, "wb") do |file|
      json_data = JSON.pretty_generate(content)
      file.write(json_data + "\n")
    end
  end
end
