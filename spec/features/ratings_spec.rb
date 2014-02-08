require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'Foobar1'
  end

  it "when given, is registered to the beer and user who is signed in" do
    expect {
      create_rating(15)
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

   it "when created, it is shown on ratings page" do
     create_rating(10)
     visit ratings_path
     expect(page).to have_content ("iso 3 Koff")

   end

  it "rating is shown on users page" do
    create_rating(5)
    visit user_path(user)
    expect(page).to have_content ("iso 3")
    expect(page).to have_content ("has 1 rating")
  end

  it "rating being deleted gets out of database" do
     create_rating(10)
     expect {
     click_link('delete')
     }.to change{Rating.count}.from(1).to(0)
     expect(page).to have_content ("no ratings given")
  end


  def create_rating(score)
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => score)
    click_button "Create Rating"
  end
end