class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery

  has_many :ratings, :dependent => :destroy

  has_many :raters, :through => :ratings, :source => :user

  validates :name, presence: true

  validates :style, presence: true

  #validates_length_of :name, :minimum => 2

#  def average_rating
  #  @m = 0
  #  self.ratings.each do |rating|
  #      @m = @m + rating.score
  #  end

   # @m = Beer.find(self.id).ratings.map(&:score).inject() { |result, element| result + element }
   # @m = self.ratings.map(&:score).inject(0) { |result, element| result + element }
   # @m
  #  Beer.find(self.id).ratings.map(&:score)
    #@x.size
   # Beer.find(self.id).ratings.map(&:score).inject() { |result, element| result + element }

 #   pluralize(Beer.find(self.id).ratings.map(&:score).size, "Beer has " + Beer.find(self.id).ratings.map(&:score).size.to_s +
 #       " rating, score " + (Beer.find(self.id).ratings.map(&:score).inject() { |result, element| result + element }/
 #       Beer.find(self.id).ratings.map(&:score).size).to_s, "Beer has " +
 #       Beer.find(self.id).ratings.map(&:score).size.to_s + " ratings, average score " +
 #                 (Beer.find(self.id).ratings.map(&:score).inject() { |result, element| result + element }/
 #                     Beer.find(self.id).ratings.map(&:score).size).to_s)
 # end

  def to_s
     b = Beer.find(self.id)
     p = Brewery.find(b.brewery_id)
     b.name + " " + p.name
  end

end