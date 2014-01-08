class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password

  has_many :ratings

  has_many :beers, :through => :ratings

  validates_uniqueness_of :username

  validates_length_of :username, :minimum => 3

  validates_length_of :username, :maximum => 15

  validates_length_of :password, :minimum => 4

  validates :password, :format => {:with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{3,}$/, message: "must contain at least one number and one letter"}

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer.style
  end

  def favorite_brewery_id
     return nil if ratings.empty?
     ratings.sort_by{ |r| r.score }.last.beer.brewery_id
  end
end
