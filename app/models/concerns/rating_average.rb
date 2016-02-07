module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return 0 if self.ratings.empty?
    average = ratings.inject(0.0){ |sum, r| sum+r.score } / ratings.count
    average.round(2)
  end
end