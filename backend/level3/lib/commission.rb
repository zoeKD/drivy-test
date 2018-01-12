class Commission
  attr_reader :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(price, duration)
    @insurance_fee = (0.15 * price).round
    @assistance_fee = 100 * duration
    remainder = ((0.3 * price) - @insurance_fee - @assistance_fee).round
    @drivy_fee = remainder > 0 ? remainder : 0
  end
end
