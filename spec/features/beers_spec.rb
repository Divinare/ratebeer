require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) { FactoryGirl.create :rating, :beer_id => beer1.id }

  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "user can insert beer to database" do
      expect(Beer.count).to eq(1)
      visit new_beer_path
      fill_in('beer[name]', :with => "sandels")
      select("Weizen", from: 'beer[style]')
      select(Brewery.first.name, from: 'beer[brewery_id]')
      click_button "Create Beer"
      expect(Beer.count).to eq(2)

  end

   it "shows user's favorite beer and brewery" do
        visit user_path(user)
        create_rating(10)
        expect(page).to have_content ("Favorite style")
        expect(page).to have_content ("Lager")
        expect(page).to have_content ("Favorite brewery")
        expect(page).to have_content ("Koff")

   end

  def create_rating(score)
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => score)
    click_button "Create Rating"
  end




end