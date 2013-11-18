class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password

  has_many :ratings

  has_many :beers, :through => :ratings

  validates_uniqueness_of :username

  validates_length_of :password, :minimum => 4

end
