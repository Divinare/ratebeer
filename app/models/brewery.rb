class Brewery < ActiveRecord::Base
  include RatingAverage
 # secure params :name, :year

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  validates :name, presence: true

  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                      :only_integer => true }

  validates :year, numericality: { less_than_or_equal_to: ->(_) { Time.now.year} }

  #validate :year_cannot_be_in_the_future
  #def year_cannot_be_in_the_future
  #     if year.present? && year > Time.now.year.to_i
  #         errors.add(:year, "year must be less than " + (Time.now.year+1).to_s)
  #     end
  # end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

end
