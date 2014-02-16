class BeerClub < ActiveRecord::Base

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  validates :name, :presence => true

  validates :city, :presence => true

  validates_numericality_of :founded, { :greater_than_or_equal_to => 1000,
                                      :less_than_or_equal_to => 2015,
                                      :only_integer => true }

end
