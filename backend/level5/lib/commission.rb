class Commission
  attr_reader :insurance_fee, :assistance_fee, :drivy_fee, :owner_share

  OWNER_SHARE = 0.7
  INSURANCE_SHARE = 0.15
  ASSISTANCE_DAILY_COST = 100

  def initialize(rental)
    @owner_share = (OWNER_SHARE * rental.price).round
    @insurance_fee = (INSURANCE_SHARE * rental.price).round
    @assistance_fee = ASSISTANCE_DAILY_COST * rental.duration
    remainder = ((1 - OWNER_SHARE) * rental.price - @insurance_fee - @assistance_fee).round
    @drivy_fee = remainder > 0 ? remainder : 0
  end
end
