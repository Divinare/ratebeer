class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_digest
  has_secure_password

  has_many :ratings

  has_many :beers, :through => :ratings

  validates_uniqueness_of :username

  validates_length_of :username, :minimum => 3

  validates_length_of :username, :maximum => 15

  validates_length_of :password, :minimum => 4

  validates :password, :format => {:with => /^(?=.*[a-zA-Z])(?=.*[0-9]).{3,}$/, message: "must contain at least one number and one letter"}



end
