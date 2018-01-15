require_relative "rental"
require_relative "commission"

class RentalModification
  attr_reader :id, :rental

  ACTORS = ["driver", "owner", "insurance", "assistance", "drivy"]

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @rental = attributes[:rental]
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance].to_i
    @new_rental = @rental.clone
    @new_rental.start_date = @start_date if @start_date
    @new_rental.end_date = @end_date if @end_date
    @new_rental.distance = @distance unless @distance.zero?
    @new_rental.commission = Commission.new(@new_rental)
  end

  def get_modified_balance(actor)
    new_balance = @rental.get_balance(actor) - @new_rental.get_balance(actor)
    actor == "driver" ? -new_balance : new_balance
  end

  def accounting_record(actor)
    new_balance = get_modified_balance(actor)
    type = new_balance < 0 ? "credit" : "debit"
    return { who: actor, type: type, amount: new_balance.abs }
  end

  def modified_actions
    modified_actions = []
    ACTORS.each do |actor|
      modified_actions << accounting_record(actor)
    end
    return modified_actions
  end
end
