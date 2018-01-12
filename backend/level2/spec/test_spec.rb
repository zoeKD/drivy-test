require "car"
require "rental"
require "date"
require "fileutils"

describe Rental do

  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:rental) { Rental.new(id: 1, car: car, start_date: Date.parse("2015-03-31"), end_date: Date.parse("2015-04-01"), distance: 300) }

  describe "#price" do
    it "compute the price of a rental based on its dates & km" do
      expect(rental.price).to eq 6800
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

end

# describe JellyBean do

#   let(:licorice_jelly) { JellyBean.new("jelly bean", 130, "black licorice") }
#   let(:fat_jelly) { JellyBean.new("jelly bean", 300, "strawberry") }

#   describe "inheritance" do
#     it "should only extend Dessert with #flavor and #delicious?" do
#       expect(JellyBean.instance_methods(false).sort).to match_array([:delicious?, :flavor])
#     end
#   end

#   describe "#flavor" do
#     it "has a flavor getter" do
#       expect(licorice_jelly.flavor).to eq "black licorice"
#     end
#   end

#   describe "#healthy?" do
#     it "inherits #healthy? from the Dessert class" do
#       expect(licorice_jelly.healthy?).to eq true
#       expect(fat_jelly.healthy?).to eq false
#     end
#   end

#   describe "#delicious?" do
#     it "has its own rules for deliciousness" do
#       expect(licorice_jelly.delicious?).to eq false
#       expect(fat_jelly.delicious?).to eq true
#     end
#   end
# end
