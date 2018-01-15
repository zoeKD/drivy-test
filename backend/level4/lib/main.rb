require_relative "input_output"

# deserialization of data.json
filepath = "data.json"
@input_output = InputOutput.new
rentals = @input_output.deserialize_data(filepath)


# computed rental prices
all_rental_prices = []
rentals.each do |rental|
  rental_options = { deductible_reduction: rental.deductible_total_price }
  rental_commission = { insurance_fee: rental.commission.insurance_fee,
                        assistance_fee: rental.commission.assistance_fee,
                        drivy_fee: rental.commission.drivy_fee }
  all_rental_prices << { id: rental.id, price: rental.price, options: rental_options, commission: rental_commission }
end

# serialized into output2.json
filepath = "output2.json"
rentals_prices = { rentals: all_rental_prices }
@input_output.serialize_data(filepath, rentals_prices)
