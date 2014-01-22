class BeerClub < ActiveRecord::Base
  # attr_accessible :city, :founded, :name

  validates :name, :presence => true

  validates :city, :presence => true

  validates_numericality_of :founded, { :greater_than_or_equal_to => 1000,
                                      :less_than_or_equal_to => 2015,
                                      :only_integer => true }

end
