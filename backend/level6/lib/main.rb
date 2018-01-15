require_relative "input_output"

filepath = "data.json"
@input_output = InputOutput.new
rental_modifications = @input_output.deserialize_data(filepath)

all_rental_modifications = []
rental_modifications.each do |modification|
  all_rental_modifications << { id: modification.id,
                                rental_id: modification.rental.id,
                                actions: modification.modified_actions }
end

filepath = "output2.json"
modifications_summary = { rental_modifications: all_rental_modifications }
@input_output.serialize_data(filepath, modifications_summary)
