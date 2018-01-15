require "car"
require "rental"
require "commission"
require "date"
require "fileutils"

describe Rental do

  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:rental) { Rental.new(id: 1, car: car, start_date: Date.parse("2015-03-31"), end_date: Date.parse("2015-04-01"), distance: 300, deductible_reduction: false) }
  let(:rental_w_deductible) { Rental.new(id: 3, car: car, start_date: Date.parse("2015-07-3"), end_date: Date.parse("2015-07-14"), distance: 1000, deductible_reduction: true)}

  describe "#price" do
    it "compute the price of a rental based on its dates & km" do
      expect(rental.price).to eq 6800
      expect(rental_w_deductible.price).to eq 27800
    end
  end

  describe "output" do
    it "computed output is the same than exercice output" do
      expect(FileUtils.compare_file('output.json', 'output2.json')).to eq true
    end
  end

  describe "#reduction" do
    it "compute the reduction rate based on the day number" do
      expect(rental.reduction(1)).to eq 1
      expect(rental.reduction(3)).to eq 0.9
      expect(rental.reduction(5)).to eq 0.7
      expect(rental.reduction(12)).to eq 0.5
    end
  end

  describe "@commission" do
    it "stores the different commission for a rental" do
      expect(rental.commission.insurance_fee).to eq 1020
      expect(rental.commission.assistance_fee).to eq 200
      expect(rental.commission.drivy_fee).to eq 820
      expect(rental_w_deductible.commission.insurance_fee).to eq 4170
      expect(rental_w_deductible.commission.assistance_fee).to eq 1200
      expect(rental_w_deductible.commission.drivy_fee).to eq 2970
    end
  end

  describe "#deductible_total_price" do
    it "compute the price of the deductible_reduction option whether subscribed or not" do
      expect(rental.deductible_total_price).to eq 0
      expect(rental_w_deductible.deductible_total_price).to eq 4800
    end
  end
end

