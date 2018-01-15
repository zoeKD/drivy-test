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

  def reduction(day_number)
    if day_number == 1
      return 1
    elsif day_number <= 4
      return 0.9
    elsif day_number <= 10
      return 0.7
    else
      return 0.5
    end
  end

  def price
    total_price = @car.price_per_km * @distance
    (1..duration).each do |day_number|
      total_price += @car.price_per_day * reduction(day_number)
    end
    return total_price.to_i
  end
end
