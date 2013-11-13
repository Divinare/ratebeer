class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score

  belongs_to :beer

  def to_s
    b = beer
    b.name + " " + score.to_s
  end
end
