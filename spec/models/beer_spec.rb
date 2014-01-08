require 'spec_helper'

describe Beer do
  describe "is not saved to database" do
    it "without name" do
      beer = Beer.create :style => "lager", :brewery_id => 1

      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
    it "without style" do
      beer = Beer.create :name => "koff", :brewery_id => 1

      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)

    end
  end
end
