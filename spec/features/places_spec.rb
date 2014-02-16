require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:id => 1, :street => "Oljenkorrenkatu") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorrenkatu"
  end

  it "if beer has more than one place, all of them are shown on the page" do
    BeermappingApi.stub(:places_in).with("kolmebaaria").and_return(
        [ Place.new(:id => 1, :name => "Eka"), Place.new(:id => 2, :name => "Toka"), Place.new(:id => 3, :name => "Kolmas") ]
    )

    visit places_path
    fill_in('city', with: "kolmebaaria")
    click_button "Search"

    expect(page).to have_content "Eka"
    expect(page).to have_content "Toka"
    expect(page).to have_content "Kolmas"
  end

  it "if beer has no places, 'No locations in' is shown on the page" do
  BeermappingApi.stub(:places_in).with("asd").and_return(
      [ ]
  )

  visit places_path
  fill_in('city', with: 'asd')
  click_button "Search"

  expect(page).to have_content "No locations in"

  end

end