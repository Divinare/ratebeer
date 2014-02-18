# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create :name => "Koff", :year => 1897
b2 = Brewery.create :name => "Malmgard", :year => 2001
b3 = Brewery.create :name => "Weihenstephaner", :year => 1042

s1 = Style.create :name => "Lager", :description => "Lager (German: storage) is a type of beer that is fermented and conditioned at low temperatures. Pale lager is the most widely consumed and commercially available style of beer in the world. Bock, Pilsner and Märzen are all styles of lager. There are also dark lagers, such as Dunkel and Schwarzbier."
s2 = Style.create :name => "Ale", :description => "Ale is a type of beer brewed from malted barley using a warm fermentation with a strain of brewers' yeast. The yeast will ferment the beer quickly, giving it a sweet, full bodied and fruity taste. Most ales contain hops, which help preserve the beer and impart a bitter herbal flavour that balances the sweetness of the malt."
s3= Style.create :name => "Porter", :description => "Porter is a dark style of beer originating in London in the 18th century,  descended from brown beer, a well hopped beer made from brown malt. The name is thought to come from its popularity with street and river porters."
s4 = Style.create :name => "Weizen", :description => "Wheat beer is a beer that is brewed with a large proportion of wheat in addition to malted barley. Wheat beers are usually top-fermented (as required by law in Germany).[1] The main varieties are weissbier (includes hefeweizen), witbier, and the sour varieties, such as lambic, Berliner Weisse and gose."

b1.beers.create :name => "Iso 3", :style => s1
b1.beers.create :name => "Karhu", :style => s1
b1.beers.create :name => "Tuplahumala", :style => s1
b2.beers.create :name => "Huvila Pale Ale", :style => s2
b2.beers.create :name => "X Porter", :style => s3
b3.beers.create :name => "Hefezeizen", :style => s4
b3.beers.create :name => "Helles", :style => s1