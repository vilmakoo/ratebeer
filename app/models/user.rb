class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }

  validates :password, length: { minimum: 4 },
            format: {
                with: /\d.*[A-Z]|[A-Z].*\d/,
                message: "has to contain one number and one upper case letter"
            }


  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
  
  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  private


  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def self.most_active(n)
    sorted_by_number_of_ratings = User.all.sort_by{ |u| -(u.ratings.size||0) }
    if sorted_by_number_of_ratings.size < n
      return sorted_by_number_of_ratings
    end
    sorted_by_number_of_ratings.take(n)
  end
end