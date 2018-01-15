require_relative "input_output"

# deserialization of data.json
filepath = "data.json"
@input_output = InputOutput.new
rentals = @input_output.deserialize_data(filepath)


# computed rental prices
all_rental_actions = []
rentals.each do |rental|
  all_rental_actions << { id: rental.id, actions: rental.actions }
end

# serialized into output2.json
filepath = "output2.json"
rentals_summary = { rentals: all_rental_actions }
@input_output.serialize_data(filepath, rentals_summary)
