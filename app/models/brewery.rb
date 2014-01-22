class Brewery < ActiveRecord::Base
  include RatingAverage

 # secure params :name, :year

  has_many :beers
  has_many :ratings, :through => :beers

  validates :name, presence: true

  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                      :only_integer => true }

  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
       if year.present? && year > Time.now.year.to_i
           errors.add(:year, "year must be less than " + (Time.now.year+1).to_s)
       end

  end

end
