require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:style) { FactoryGirl.create :style, name:"Lager" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", style:style, brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) { FactoryGirl.create :rating, :beer_id => beer1.id }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "user can insert beer to database" do
      expect(Beer.count).to eq(1)
      visit new_beer_path
      fill_in('beer[name]', :with => "sandels")
      select(Style.first.name, from: 'beer[style_id]')
      select(Brewery.first.name, from: 'beer[brewery_id]')
      click_button "Create Beer"
      expect(Beer.count).to eq(2)

  end

  def create_rating(score)
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => score)
    click_button "Create Rating"
  end




end