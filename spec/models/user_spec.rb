require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end
  it "is not saved without a proper password" do
    user = User.create :username => "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "without a proper password" do

    it "is not saved with password containing only letters" do
      user = User.create :username => "Pekka", :password => "jeejee", :password_confirmation => "jeejee"

      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
    it "is not saved with too short password" do
      user = User.create :username => "Pekka", :password => "a1", :password_confirmation => "a1"

      expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating 10, user

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings 10, 20, 15, 7, 9, user
      best = create_beer_with_rating 25, user

      expect(user.favorite_beer).to eq(best)
    end
   end

  describe "favorite style" do
     let(:user){FactoryGirl.create(:user) }

      it "has method for determining one" do
        user.should respond_to :favorite_style
      end

     it "without ratings does not have one" do
       expect(user.favorite_style).to eq(nil)
     end

     it "is the only rated if only one rating" do
       beer = create_beer_with_style_and_rating("koff", 10, user)

       expect(user.favorite_style).to eq(beer.style)
     end

     it "is the one with highest rating if several rated" do
       create_beer_with_styles_and_ratings 10, 20, 15, 7, 9, user
       best = create_beer_with_style_and_rating("super", 25, user)

       expect(user.favorite_style).to eq(best.style)
     end

  end

  describe "favorite_brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery_id
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery_id).to eq(nil)
    end

    it "is the only one if there is only one rating" do
      beer = create_beer_with_rating(10, user)
      brewery = create_brewery(beer)
      expect(user.favorite_brewery_id).to eq(beer.brewery_id)
    end

    it "is the one with highest rated beer if several beers are rated" do
      beers = create_beers_with_ratings(10, 20, 15, 7, 9, user)
      create_brewery(beers)
      best = create_beer_with_rating(25, user)
      best2 = create_brewery(best)
      expect(user.favorite_brewery_id).to eq(best.brewery_id)
    end

  end

  def create_beer_with_style_and_rating(style, score, user)
    beer = FactoryGirl.create(:beer, :style => style)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end

  def create_beer_with_styles_and_ratings(*scores, user)
    styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    scores.each do |score|
       style = styles.shift
       if style.nil?
         styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
         style = styles.shift
       end
      create_beer_with_style_and_rating(style, score, user)
    end

  end

  def create_beer_with_rating(score,  user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating score, user
    end
  end

  def create_brewery(*beers)
    FactoryGirl.create(:brewery, :name => "tehdas")
    beers
  end


end