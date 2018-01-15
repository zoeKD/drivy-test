require_relative "commission"

class Rental
  attr_reader :id, :car
  attr_writer :start_date, :end_date, :distance
  attr_accessor :commission

  DEDUCTIBLE_PRICE = 400
  DECREASE_RATE_1 = 1
  DECREASE_RATE_2 = 0.9
  DECREASE_RATE_3 = 0.7
  DECREASE_RATE_4 = 0.5
  ACTORS = ["driver", "owner", "insurance", "assistance", "drivy"]

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @car = attributes[:car]
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance].to_i
    @deductible_reduction = attributes[:deductible_reduction] == "true" || attributes[:deductible_reduction] == true
    @commission = Commission.new(self)
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  def deductible_total_price
    @deductible_reduction ? DEDUCTIBLE_PRICE * duration : 0
  end

  def price
    total_price = @car.price_per_km * @distance
    (1..duration).each do |day_number|
      total_price += @car.price_per_day * reduction(day_number)
    end
    return total_price.to_i
  end

  def reduction(day_number)
    if day_number == 1
      return DECREASE_RATE_1
    elsif day_number <= 4
      return DECREASE_RATE_2
    elsif day_number <= 10
      return DECREASE_RATE_3
    else
      return DECREASE_RATE_4
    end
  end

  def get_balance(actor)
    case actor
    when "driver" then price + deductible_total_price
    when "owner" then @commission.owner_share
    when "insurance" then @commission.insurance_fee
    when "assistance" then @commission.assistance_fee
    when "drivy" then @commission.drivy_fee + deductible_total_price
    else "unknown"
    end
  end

  def accounting_record(actor)
    type = actor == "driver" ? "debit" : "credit"
    return { who: actor, type: type, amount: get_balance(actor) }
  end

  def actions
    actions = []
    ACTORS.each do |actor|
      actions << accounting_record(actor)
    end
    return actions
  end
end
