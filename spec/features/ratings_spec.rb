require 'spec_helper'

include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style, name:"Lager" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", style:style, brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", style:style, brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when many exists" do
    before :each do
      user2 = FactoryGirl.create(:user, username:'Arto')

      FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
      FactoryGirl.create(:rating, score:20, beer:beer1, user:user2)
      FactoryGirl.create(:rating, score:30, beer:beer2, user:user)
    end

    it "all are listed at the ratings page" do
      visit ratings_path
      expect(page).to have_content "10 #{beer1.name}"
      expect(page).to have_content "20 #{beer1.name}"
      expect(page).to have_content "30 #{beer2.name}"
    end

    it "only users own are shown at users page" do
      visit user_path(user)
      expect(page).to have_content '2 ratings'
      expect(page).to have_content "10 #{beer1.name}"
      expect(page).to have_content "30 #{beer2.name}"
      expect(page).not_to have_content "20 #{beer1.name}"
    end

    it "user can delete one of his own" do
      visit user_path(user)

      expect{
        page.first('a', text:'Destroy').click
      }.to change{Rating.count}.by(-1)
    end
  end
end