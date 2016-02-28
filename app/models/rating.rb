class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user # rating kuuluu myös käyttäjään

  validates :score, numericality: {greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 50,
                                   only_integer: true}

  scope :recent, -> {order(created_at: :desc).limit(5)}

  def to_s
    merkkijono = beer.name + " " + score.to_s
  end

end
