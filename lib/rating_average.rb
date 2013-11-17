module RatingAverage
  def average_rating
    if ratings.size == 0
      return 0
    end
    b = 0
    ratings.each do |rating|
      b = b + rating.score
    end
    b/ratings.count
  end
end