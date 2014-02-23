class Style < ActiveRecord::Base
#  include RatingAverage
  has_many :beers


  def to_s
    name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(average_rating(b)||0) }
    sorted_by_rating_in_desc_order.take(n)
  end


  def self.average_rating(style)
    num = 0
    beers = Beer.where(:style_id => style.id)
    beers.each do |beer|
      num = num + beer.average_rating
    end
    num/beers.count
  end

  def average_rating(style)
    num = 0
    beers = Beer.where(:style_id => style.id)
    beers.each do |beer|
      num = num + beer.average_rating
    end
    num/beers.count
  end
end

