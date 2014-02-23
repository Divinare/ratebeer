# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#u1 = User.create :username => "Div", :password_digest => "haha"

b1 = Brewery.create :name => "Koff", :year => 1897, :active => true
b2 = Brewery.create :name => "Malmgard", :year => 2001, :active => true
b3 = Brewery.create :name => "Weihenstephaner", :year => 1042, :active => false
b4 = Brewery.create :name => "Olvi", :year => 1878, :active => true

Style.create :name => "Lager", :description => "Lager (German: storage) is a type of beer that is fermented and conditioned at low temperatures. Pale lager is the most widely consumed and commercially available style of beer in the world. Bock, Pilsner and M'a'rzen are all styles of lager. There are also dark lagers, such as Dunkel and Schwarzbier."
Style.create :name => "Ale", :description => "Ale is a type of beer brewed from malted barley using a warm fermentation with a strain of brewers' yeast. The yeast will ferment the beer quickly, giving it a sweet, full bodied and fruity taste. Most ales contain hops, which help preserve the beer and impart a bitter herbal flavour that balances the sweetness of the malt."
Style.create :name => "Porter", :description => "Porter is a dark style of beer originating in London in the 18th century,  descended from brown beer, a well hopped beer made from brown malt. The name is thought to come from its popularity with street and river porters."
Style.create :name => "Weizen", :description => "Wheat beer is a beer that is brewed with a large proportion of wheat in addition to malted barley. Wheat beers are usually top-fermented (as required by law in Germany).[1] The main varieties are weissbier (includes hefeweizen), witbier, and the sour varieties, such as lambic, Berliner Weisse and gose."

b1.beers.create :name => "Iso 3", :style_id => 1
b1.beers.create :name => "Karhu", :style_id => 1
b1.beers.create :name => "Tuplahumala", :style_id => 1
b2.beers.create :name => "Huvila Pale Ale", :style_id => 2
b2.beers.create :name => "X Porter", :style_id => 3
b3.beers.create :name => "Hefezeizen", :style_id => 4
b3.beers.create :name => "Helles", :style_id => 1
b4.beers.create :name => "Sandels", :style_id => 1
b4.beers.create :name => "Olvi III", :style_id => 1

User.create username:"Div", password:"AAA1", password_confirmation:"AAA1", admin:"true"
User.create username:"Dov", password:"AAA1", password_confirmation:"AAA1", admin:"false"
User.create username:"Dev", password:"AAA1", password_confirmation:"AAA1", admin:"false"

BeerClub.create name:"Kumpulan kerma", founded:2003, city:"Helsinki"
BeerClub.create name:"Kaljakeijot", founded:2009, city:"Vantaa"

Rating.create :score => 3, :beer_id => 1, :user_id => 1
Rating.create :score => 5, :beer_id => 2, :user_id => 1
Rating.create :score => 3, :beer_id => 3, :user_id => 1
Rating.create :score => 2, :beer_id => 4, :user_id => 1
Rating.create :score => 3, :beer_id => 5, :user_id => 1
Rating.create :score => 1, :beer_id => 6, :user_id => 1
Rating.create :score => 5, :beer_id => 9, :user_id => 1
Rating.create :score => 4, :beer_id => 1, :user_id => 2
Rating.create :score => 4, :beer_id => 2, :user_id => 2
Rating.create :score => 4, :beer_id => 3, :user_id => 2
Rating.create :score => 4, :beer_id => 2, :user_id => 2
Rating.create :score => 1, :beer_id => 3, :user_id => 3
Rating.create :score => 1, :beer_id => 4, :user_id => 3
Rating.create :score => 1, :beer_id => 5, :user_id => 3
Rating.create :score => 5, :beer_id => 6, :user_id => 3
Rating.create :score => 5, :beer_id => 7, :user_id => 3

Membership.create :beer_club_id => 1, :user_id => 1
Membership.create :beer_club_id => 2, :user_id => 2
Membership.create :beer_club_id => 2, :user_id => 3