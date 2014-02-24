module RatingAverage

  def average_rating
    return 0 if ratings.length == 0
    (ratings.pluck(:score).inject { |res, el| res + el } / ratings.count.to_f)
  end

end