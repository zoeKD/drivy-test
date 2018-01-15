# Defining a model for rentals
class Rental
  attr_reader :id

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @car = attributes[:car]
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance].to_i
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  def price
    duration * @car.price_per_day + @car.price_per_km * @distance
  end
end
