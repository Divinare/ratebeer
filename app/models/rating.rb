class Rating < ActiveRecord::Base
  include RatingAverage

  validates_numericality_of :score, { :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 50,
                                      :only_integer => true }

  scope :recent, -> { Rating.limit(5).order(:created_at) }

  belongs_to :beer
  belongs_to :user


  def to_s
     score.to_s
  end
end
