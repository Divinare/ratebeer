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

  public

  def average_rating(style)
    num = 0
    beers = Beer.where(:style_id => style.id)
    beers.each do |beer|
      num = num + beer.average_rating
    end
    num/beers.count
  end

  def self.top_styles(n)
    ratings = []
    Style.all.each do |style|

      num = 0
      beers = Beer.where(:style_id => style.id)
      beers.each do |beer|
        num = num + beer.average_rating
      end
      ratings.push(num/beers.count)

    end
    ratings.sort.take(n)
  end
end

