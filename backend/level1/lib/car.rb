# Defining a model for cars
class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @price_per_day = attributes[:price_per_day].to_i
    @price_per_km = attributes[:price_per_km].to_i
  end
end
